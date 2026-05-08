package com.fyp.Ghumantey.config;

import java.util.Arrays;
import java.util.List;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.fyp.Ghumantey.service.IngestionService;

@Configuration
public class DataInitializer {

    @Bean
    CommandLineRunner initAiKnowledge(IngestionService ingestionService) {
        return args -> {
            List<String> knowledgeBase = Arrays.asList(
                // 1. Core Identity & Voice
                "Identity: Ghumantey AI is a specialized Sherpa-inspired assistant designed to help users navigate trekking in Nepal through the Ghumantey platform.",
                "Tone: Helpful, safety-conscious, and respectful of Nepali culture. Always use 'Namaste' in greetings.",

                // 2. Platform Mechanics
                "Platform Features: Ghumantey provides real-time guide booking, verified hotel listings, and curated trekking itineraries.",
                "Booking Process: To hire a guide, go to the 'Guides' tab, select a profile, and check their availability calendar.",
                "Verification: The 'Ghumantey Verified' badge means the guide's license (NATHM certified) and background have been manually checked.",
                "eSewa Integration: Ghumantey supports secure payments via eSewa for booking deposits.",

                // 3. Expert Trekking Knowledge - Everest Region (Deep Dive)
                "Everest Base Camp (EBC): Duration 12-14 days. Maximum altitude 5,364m. Highlights include Namche Bazaar, Tengboche Monastery, and Kala Patthar.",
                "Three Passes Trek: The ultimate Everest challenge. Crosses Kongma La, Cho La, and Renjo La. Requires high physical fitness and previous experience.",
                "Gokyo Lakes: A stunning alternative to EBC, featuring emerald green glacial lakes and the crossing of Cho La Pass.",
                "Lukla Flight: Most Everest treks begin with a flight to Lukla (Tenzing-Hillary Airport), often called the most dangerous airport in the world due to its short runway.",

                // 4. Annapurna, Mustang & Other Regions
                "Annapurna Base Camp (ABC): 7-10 days. Known for the 'Annapurna Sanctuary'—a high-altitude basin surrounded by mountains.",
                "Mardi Himal: A hidden gem. Offers close-up views of Machhapuchhre (Fishtail) and the Annapurna range with fewer crowds.",
                "Upper Mustang: The 'Forbidden Kingdom'. A rain-shadow desert trek with Tibetan-style culture and ancient caves. Requires a $500 restricted area permit.",
                "Poon Hill: 4-5 days. Best for beginners and famous for the sunrise view over the Dhaulagiri and Annapurna ranges.",
                "Manaslu Circuit: 14-18 days. A restricted area trek that requires a special permit and at least two trekkers plus a guide.",

                // 5. Safety & Altitude (AMS)
                "Altitude Sickness (AMS): Symptoms include headache, nausea, and dizziness. Ghumantey recommends 'climb high, sleep low' and staying hydrated.",
                "Acclimatization: Proper treks include rest days at Namche Bazaar (3,440m) and Dingboche (4,410m) for EBC.",
                "Emergency: Ghumantey guides are trained in First Aid and can coordinate helicopter evacuations via the platform's support line.",
                "Garbage Disposal: Ghumantey promotes 'Leave No Trace'. Trekkers should carry out non-biodegradable waste.",

                // 6. Cultural Etiquette for Trekkers
                "Mani Walls: Always walk to the left of Mani walls (prayer-carved stones) and Chortens in a clockwise direction.",
                "Prayer Flags: Never step over or sit on prayer flags. They represent sacred blessings.",
                "Photography: Always ask for permission before taking photos of local people or inside monasteries (Gumbas).",
                "Tipping: Tipping guides and porters is a standard practice in Nepal, typically 10-15% of the total trekking cost.",

                // 7. Gear & Logistics
                "Best Seasons: Spring (March-May) for rhododendrons; Autumn (Sept-Nov) for crystal clear mountain views.",
                "Water: Never drink tap water. Use water purification tablets (LifeStraw/Chlorine) or buy boiled water at teahouses.",
                "Charging: Most teahouses charge extra (NPR 200-500) to charge phones and power banks using solar power.",
                "SIM Cards: Ncell and NTC both work in the mountains, but NTC generally has better coverage in the Everest region (4G available in Namche)."
            );

            ingestionService.loadTrekkingData(knowledgeBase);
            System.out.println("Ghumantey AI Knowledge Base Training Complete!");
        };
    }
}