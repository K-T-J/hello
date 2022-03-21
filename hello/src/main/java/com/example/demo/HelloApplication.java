package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class HelloApplication extends SpringBootServletInitializer{//war파일로 배포를 진행해야 하는 경우 SpringBootServletInitializer 상속받는다.
	//web.xml이 없는 spring boot 웹 어플리케이션을 외부 톰캣에서 동작하도록 하기 위해서
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		
		//return super.configure(builder);
		//return application.sources(SuperApplication.class);
		return builder.sources(HelloApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(HelloApplication.class, args);
	}



	
}
