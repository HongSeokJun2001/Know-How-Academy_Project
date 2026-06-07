package com.kh.know_how.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	@Transactional
	public int insertMember(Member m) {
		
		return memberDao.insertMember(sqlSession, m);
	}
	
	@Transactional
	public int updateMember(Member m) {
	
		return memberDao.updateMember(sqlSession, m);
	}
	
	@Transactional
	public int updatePwd(Member m) {
		
		return memberDao.updatePwd(sqlSession, m);
	}
	
	public int searchId(Member m) {
		
		return memberDao.searchId(sqlSession, m);
	}
	
	public int searchPassword(Member m) {
		
		return memberDao.searchPassword(sqlSession, m);
	}
	
	@Transactional
	public int deleteMember(String userId) {
		
		return memberDao.deleteMember(sqlSession, userId);
	}
	
	public int idCheck(String checkId) {
		
		return memberDao.idCheck(sqlSession, checkId);
	}
	
	
	
	
}
