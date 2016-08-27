package com.gmail.antonsyzko.doctoradministrationpanel.utils;

/**
 * Created by Admin on 06.08.2016.
 */

/*
demo use
 */

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

//not really used - hardcoded at DB
public class QuickPasswordEncodingGenerator {

    /**
     * @param args
     */

    private PasswordEncoder passwordEncoder;

    public static void main(String[] args) {
        String password = "testAdmin";
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

        System.out.println(passwordEncoder.encode(password));


       /*
        INSERT INTO APP_USER(sso_id, password, first_name, last_name, email)
VALUES ('bob','$2a$10$pF61kw77wUhDZyYoiJrQzuLB3JfRfvl4x8mIAxtD4FXBBjpQF43KC', 'bob','bob','bob@xyz.com');
         */


        //$2a$10$pF61kw77wUhDZyYoiJrQzuLB3JfRfvl4x8mIAxtD4FXBBjpQF43KC

        //$2a$10$pF61kw77wUhDZyYoiJrQzuLB3JfRfvl4x8mIAxtD4FXBBjpQF43KC

    }



}

// //$2a$10$pF61kw77wUhDZyYoiJrQzuLB3JfRfvl4x8mIAxtD4FXBBjpQF43KC
// //$2a$10$pF61kw77wUhDZyYoiJrQzuLB3JfRfvl4x8mIAxtD4FXBBjpQF43KC
// //$2a$10$pF61kw77wUhDZyYoiJrQzuLB3JfRfvl4x8mIAxtD4FXBBjpQF43KC