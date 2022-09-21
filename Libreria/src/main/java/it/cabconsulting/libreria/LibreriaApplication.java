package it.cabconsulting.libreria;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class LibreriaApplication {
	
	
	@GetMapping("/welcome")
	public String welcome() {
		return "demo";
	}

	public static void main(String[] args) {
		SpringApplication.run(LibreriaApplication.class, args);
	}

}
