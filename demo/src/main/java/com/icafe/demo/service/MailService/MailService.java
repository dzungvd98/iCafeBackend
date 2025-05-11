package com.icafe.demo.service.MailService;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring6.SpringTemplateEngine;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MailService {
    
    private final JavaMailSender mailSender;
    private final SpringTemplateEngine springTemplateEngine;

    @Value("${spring.mail.from}")
    private String emailFrom;

    @SuppressWarnings("null")
    public String sendEmail(String recipents, String subject, String content, MultipartFile[] files) throws MessagingException, UnsupportedEncodingException {
        log.info("Sending email to: {}, subject: {}, content: {}", recipents, subject, content);

        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        helper.setFrom(emailFrom, "ICafe"); //thiết lập tên hiển thị khi gửi mail thay vì ghi rõ địa chỉ mail

        if(recipents.contains(",")) {
            helper.setTo(InternetAddress.parse(recipents));
        } else {
            helper.setTo(recipents);
        }

        if(files != null) {
            for(MultipartFile file : files) {
                helper.addAttachment(file.getOriginalFilename(), file);
            }
        }

        helper.setSubject(subject);
        helper.setText(content, true);

        mailSender.send(message);
        log.info("Email has been send successfully, recipents={}", recipents);
        return "sent";
    }

    public void sendConfirmLink(String email, Integer id, String string) throws MessagingException, UnsupportedEncodingException {
        log.info("Sending email confirm account");
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED, StandardCharsets.UTF_8.name());       
        
        Context context = new Context();
        
        String linkConfirm = "/users/userid/?secretCode=";

        Map<String, Object> properties = new HashMap<>();
        properties.put("linkConfirm", linkConfirm);
        context.setVariables(properties);

        helper.setFrom(emailFrom, "ICafe");
        helper.setTo(email);
        helper.setSubject("Please confirm your account");

        String html = springTemplateEngine.process("confirm-email.html", context);
        helper.setText(html, true);

        mailSender.send(message);

        log.info("Email sent!");
    }
}
