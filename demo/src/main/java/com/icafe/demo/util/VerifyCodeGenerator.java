package com.icafe.demo.util;

import java.security.SecureRandom;
import java.util.UUID;

public class VerifyCodeGenerator {
    private static final SecureRandom random = new SecureRandom();
    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    // UUID dạng dài
    public static String generateUUIDCode() {
        return UUID.randomUUID().toString();
    }

    // Mã alphanumeric ngắn
    public static String generateAlphaNumericCode() {
        StringBuilder sb = new StringBuilder(10);
        for (int i = 0; i < 10; i++) {
            sb.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length())));
        }
        return sb.toString();
    }

    // Mã số OTP
    public static String generateNumericCode() {
        int otp = random.nextInt(1_000_000);
        return String.format("%06d", otp);
    }
}
