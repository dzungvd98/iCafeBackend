package com.icafe.demo.service.MailService;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.annotation.KafkaListener;
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
    
    public void sendConfirmLink(String email, Integer userId, String secretCode) throws MessagingException, UnsupportedEncodingException {
        log.info("Sending email confirm account");
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED, StandardCharsets.UTF_8.name());       
        
        Context context = new Context();
        

        String linkConfirm = String.format("http://localhost:8080/api/v1/users/%s/confirm?secretCode=%s", userId, secretCode);

        Map<String, Object> properties = new HashMap<>();
        properties.put("linkConfirm", linkConfirm);
        context.setVariables(properties);

        helper.setFrom(emailFrom, "ICafe");
        helper.setTo(email);
        helper.setSubject("Please confirm your account");

        String html = springTemplateEngine.process("confirm-email.html", context);
        helper.setText(html, true);

        mailSender.send(message);

        log.info("Email sent to {}!", email);
    }

    @KafkaListener(topics = "confirm-account-topic", groupId = "confirm-account-group")
    private void sendConfirmLinkByKafka(String message) throws MessagingException, UnsupportedEncodingException {
        log.info("Sending link confirm user ...");
        
        String[] arr = message.split(",");
        String emailTo = arr[0];
        String username = arr[1];
        String verifyCode = arr[2];
        
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED, StandardCharsets.UTF_8.name());       
        
        Context context = new Context();
        

        String linkConfirm = String.format("http://localhost:8080/api/v1/users/%s/confirm?secretCode=%s", username, verifyCode);

        Map<String, Object> properties = new HashMap<>();
        properties.put("linkConfirm", linkConfirm);
        context.setVariables(properties);

        helper.setFrom(emailFrom, "ICafe");
        helper.setTo(emailTo);
        helper.setSubject("Please confirm your account");

        String html = springTemplateEngine.process("confirm-email.html", context);
        helper.setText(html, true);

        mailSender.send(mimeMessage);

        log.info("Link has sent to user, email = {}!", emailTo);
    }
}
