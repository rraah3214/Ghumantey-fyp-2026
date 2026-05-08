package com.fyp.Ghumantey.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class GhumanteyConfig implements WebMvcConfigurer {

    @Autowired
    private DataSource dataSource;

    @Value("${app.upload.dir}")
    private String uploadDir;

    /**
     * RESOURCE HANDLER:
     * This maps the URL path /uploads/** to the actual physical folder on your disk.
     * Fixed logic to prevent path doubling and ensure cross-platform compatibility.
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        String uploadPath = System.getProperty("user.dir") + "/uploads/";

        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:" + uploadPath)
                .setCachePeriod(0);

        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
    }

    // ================= SECURITY FILTER =================
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        http
            .csrf(csrf -> csrf.disable()) // Disabled for development; enable with .csrfTokenRepository for production

            .authorizeHttpRequests(auth -> auth
            		.requestMatchers("/payment-success/**", "/payment-failure/**").permitAll()                // 1. Static Resources & Uploads
                .requestMatchers("/uploads/**").permitAll()
                .requestMatchers("/css/**", "/js/**", "/images/**", "/fonts/**", "/static/**").permitAll()

                // 2. Public Pages
                .requestMatchers("/", "/home", "/login", "/signup", "/search", "/explore-treks").permitAll()
                .requestMatchers("/user/adventure", "/user/adventure-detail/**", "/user/about").permitAll()
                .requestMatchers("/api/chat", "/api/chat/**").permitAll()
                .requestMatchers("/verify-otp", "/process-otp").permitAll()

                // 3. Protected Routes
                .requestMatchers("/user/userprofile", "/user/dashbord").authenticated()
                .requestMatchers("/user/cart/**", "/booking/**").authenticated()

                // 4. Role-Specific Dashboards
                .requestMatchers("/admin/**").hasRole("ADMIN")
                .requestMatchers("/hotel/**").hasRole("HOTEL")
                .requestMatchers("/guide/**").hasRole("GUIDE")

                // 5. Catch-all
                .anyRequest().permitAll()
            )

            .formLogin(login -> login
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .successHandler(roleBasedRedirectHandler())
                .failureUrl("/login?failed=true")
                .permitAll()
            )

            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout=true")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID", "remember-me")
                .permitAll()
            )

            .rememberMe(remember -> remember
                .tokenRepository(persistentTokenRepository())
                .tokenValiditySeconds(60 * 60 * 24 * 30) // 30 Days
                .key("Ghumantey_2026_SecureKey")
                .rememberMeParameter("remember-me")
            );

        return http.build();
    }

    // ================= USER DETAILS (JDBC) =================
    @Bean
    public UserDetailsService userDetailsService() {
        JdbcDaoImpl jdbcDao = new JdbcDaoImpl();
        jdbcDao.setDataSource(dataSource);

        jdbcDao.setUsersByUsernameQuery(
            "SELECT username, password, active FROM user_detail_table WHERE username=?"
        );

        jdbcDao.setAuthoritiesByUsernameQuery(
            "SELECT ud.username, ur.role FROM user_detail_table ud " +
            "JOIN user_role ur ON ud.id = ur.user_id WHERE ud.username=?"
        );

        return jdbcDao;
    }

    // ================= REMEMBER ME TOKEN =================
    @Bean
    public PersistentTokenRepository persistentTokenRepository() {
        JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
        tokenRepository.setDataSource(dataSource);
        return tokenRepository;
    }

    // ================= ROLE BASED REDIRECT =================
    @Bean
    public AuthenticationSuccessHandler roleBasedRedirectHandler() {
        return (request, response, authentication) -> {
            response.sendRedirect("/verify-otp");
        };
    }
}