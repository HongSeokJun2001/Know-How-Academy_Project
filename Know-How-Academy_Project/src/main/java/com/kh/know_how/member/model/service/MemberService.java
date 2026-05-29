package com.kh.know_how.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.know_how.member.model.dao.MemberDao;
import com.kh.know_how.member.model.vo.Member;

@Service 
public class MemberService {
   
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MemberDao memberDao;
	
	public Member loginMember(Member m) {
		
		return memberDao.loginMember(sqlSession,m);
	}
	
	public int insertMember(Member m) {
		
		return memberDao.insertMember(sqlSession, m);
	}
	
	
}
