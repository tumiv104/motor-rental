/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

import com.cloudinary.Cloudinary;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Nitro
 */
public class CloudinaryConfig {

    public static Cloudinary config() {
        Map<String, String> config = new HashMap<>();
        config.put("cloud_name", "dgeq5yymz");
        config.put("api_key", "632666921434312");
        config.put("api_secret", "h2eX1AkVLPsRkAvzd8TR-ZKxfjk");
        return new Cloudinary(config);
    }
}
