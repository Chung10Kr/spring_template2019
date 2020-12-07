package kr.co.common.com.utils;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;

/**
 * @author emunhi
 *
 */
@Configuration
@PropertySource("classpath:properties/globals.properties")
public class WebConfig {

	   static Environment environment;
       @Bean
       public static PropertySourcesPlaceholderConfigurer propertyConfig() {
             return new PropertySourcesPlaceholderConfigurer();
       };
       
       @Autowired
       public void setEnvironment(Environment env) {
             environment = env;
       }
       public static String getProperty(String key){
    	 return environment.getProperty(key);  
       };
}