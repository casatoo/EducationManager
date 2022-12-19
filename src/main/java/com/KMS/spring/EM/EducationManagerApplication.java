package com.KMS.spring.EM;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;

@SpringBootApplication
public class EducationManagerApplication {

	public static void main(String[] args) {
		SpringApplication.run(EducationManagerApplication.class, args);
	}
	
	
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(EducationManagerApplication.class);
	}

}
