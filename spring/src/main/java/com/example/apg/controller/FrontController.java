package com.example.apg.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/front")
public class FrontController {
    
    @RequestMapping("/createChatRoom")
    public ResponseEntity<?> createChatRoom() {

        String result = "test";


        return new ResponseEntity<>(result, HttpStatus.OK);
        
    }
}
