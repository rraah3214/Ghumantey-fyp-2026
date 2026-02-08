package com.fyp.Ghumantey.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.core.Authentication;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Configuration
public class GhumanteyConfig {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                
                .requestMatchers("/admin/**").hasRole("ADMIN")
                .requestMatchers("/hotel/**").hasRole("HOTEL")
                .requestMatchers("/guide/**").hasRole("GUIDE")
                .requestMatchers("/**") .permitAll()
                .anyRequest().authenticated()
                
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
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .logoutSuccessUrl("/login?logout=true")
                .permitAll()
            );

        return http.build();
    }

    @Bean
    public AuthenticationSuccessHandler roleBasedRedirectHandler() {
        return (HttpServletRequest request,
                HttpServletResponse response,
                Authentication authentication) -> {

            String role = authentication.getAuthorities()
                    .iterator().next().getAuthority();

            if ("ROLE_ADMIN".equals(role)) {
                response.sendRedirect("/admin/dashbord");
            } else if ("ROLE_GUIDE".equals(role)) {
                response.sendRedirect("/guide/dashbord");
            } else if ("ROLE_HOTEL".equals(role)) {
                response.sendRedirect("/hotel/dashbord");
            } else {
                response.sendRedirect("/home");
            }
        };
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication()
            .dataSource(dataSource)
            .passwordEncoder(passwordEncoder)
            .usersByUsernameQuery(
                "SELECT username, password, active " +
                "FROM user_detail_table WHERE username=?"
            )
            .authoritiesByUsernameQuery(
                "SELECT ud.username, ur.role " +
                "FROM user_detail_table ud " +
                "JOIN user_role ur ON ud.id = ur.user_id " +
                "WHERE ud.username=?"
            );
    }
}
