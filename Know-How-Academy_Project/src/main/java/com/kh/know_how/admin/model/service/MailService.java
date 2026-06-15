package com.kh.know_how.admin.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import com.kh.know_how.admin.model.dto.CounselorInviteDto;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;


@Component
public class MailService {
	
	
	@Autowired 
	private JavaMailSender mailSender;
	
	
    public String sendCounselorInviteMail(CounselorInviteDto counselorInvite) {
    	
    	String inviteUrl = counselorInvite.getInviteUrl()+counselorInvite.getInviteToken();
    	
    	//메일발송
		String html = """
			<div style="width:100%%; background-color:#f4f6f8; padding:30px 0; font-family:Arial, sans-serif;">
			  <div style="max-width:600px; margin:0 auto; background-color:#ffffff; border-radius:12px; overflow:hidden; border:1px solid #e5e7eb;">

			    <div style="background-color:#4f46e5; padding:24px; text-align:center;">
			      <h1 style="margin:0; color:#ffffff; font-size:24px;">
			        Know-How Academy
			      </h1>
			    </div>

			    <div style="padding:32px;">
			      <h2 style="margin-top:0; color:#111827; font-size:22px;">
			        상담사 초대 안내
			      </h2>

			      <p style="color:#374151; font-size:15px; line-height:1.7;">
			        안녕하세요, <strong>%s</strong>님.<br>
			        Know-How Academy 상담사 계정 생성을 위한 초대 메일입니다.
			      </p>

			      <p style="color:#374151; font-size:15px; line-height:1.7;">
			        아래 버튼을 클릭하여 회원가입을 진행해주세요.
			      </p>

			      <div style="text-align:center; margin:32px 0;">
			        <a href="%s"
			           style="display:inline-block; background-color:#4f46e5; color:#ffffff;
			                  text-decoration:none; padding:14px 28px; border-radius:8px;
			                  font-size:16px; font-weight:bold;">
			          계정 생성하기
			        </a>
			      </div>

			      <p style="color:#6b7280; font-size:13px; line-height:1.6;">
			        버튼이 동작하지 않는 경우 아래 링크를 복사하여 브라우저 주소창에 입력해주세요.
			      </p>

			      <p style="word-break:break-all; color:#4f46e5; font-size:13px;">
			        %s
			      </p>

			      <hr style="border:none; border-top:1px solid #e5e7eb; margin:28px 0;">

			      <p style="color:#9ca3af; font-size:12px; line-height:1.6;">
			        본 메일은 Know-How Academy 관리자에 의해 발송된 초대 메일입니다.<br>
			        초대 요청을 받지 않으셨다면 이 메일을 무시해주세요.
			      </p>
			    </div>
			  </div>
			</div>
			""".formatted(counselorInvite.getCounselorName(), inviteUrl, inviteUrl);
		
		MimeMessage message = mailSender.createMimeMessage();
		
		try {
			
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			
			helper.setTo(counselorInvite.getEmail());
			helper.setBcc("tldpsldk@gmail.com");
			helper.setSubject("[Know-How Academy] 상담사 초대 안내");
			helper.setText(html, true); 
			
			mailSender.send(message);
			
			
		} catch (MessagingException | MailException e) {
			
			e.printStackTrace();
			return "MAIL_FAIL";
		}

    	return "SUCCESS";
    }

}
