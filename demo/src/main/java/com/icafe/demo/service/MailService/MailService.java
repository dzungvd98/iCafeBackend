package com.icafe.demo.service.MailService;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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

    @Value("${spring.mail.from}")
    private String emailFrom;

    @SuppressWarnings("null")
    public String sendEmail(String recipents, String subject, String content, MultipartFile[] files) throws MessagingException {
        log.info("Sending email to: {}, subject: {}, content: {}", recipents, subject, content);

        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        helper.setFrom(emailFrom); // TODO

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
}
