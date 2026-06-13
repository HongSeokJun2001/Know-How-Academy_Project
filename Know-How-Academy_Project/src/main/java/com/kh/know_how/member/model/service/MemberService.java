package com.kh.know_how.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.know_how.member.model.dao.MemberDao;
import com.kh.know_how.member.model.vo.Member;
import com.kh.know_how.member.model.vo.MemberLock;

@Service 
public class MemberService {
   
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MemberDao memberDao;
	
	public Member loginMember(String userId) {
		
		return memberDao.loginMember(sqlSession, userId);
	}
	
	@Transactional
	public int insertMember(Member m) {
		
		return memberDao.insertMember(sqlSession, m) * memberDao.insertMemberLock(sqlSession);
	}
	
	@Transactional
	public int updateMember(Member m) {
	
		return memberDao.updateMember(sqlSession, m);
	}
	
	@Transactional
	public int updatePwd(Member m) {
		
		return memberDao.updatePwd(sqlSession, m);
	}
	
	public Member searchId(Member m) {
		
		return memberDao.searchId(sqlSession, m);
	}
	
	public Member searchPassword(Member m) {
		
		return memberDao.searchPassword(sqlSession, m);
	}
	
	@Transactional
	public int deleteMember(String userId) {
		
		return memberDao.deleteMember(sqlSession, userId);
	}
	
	public int idCheck(String checkId) {
		
		return memberDao.idCheck(sqlSession, checkId);
	}
	
    public int emailCheck(String checkEmail) {
		
		return memberDao.emailCheck(sqlSession, checkEmail);
	}

	public MemberLock loginLockMember(int userNo) {

		return memberDao.loginLockMember(sqlSession, userNo);
	}
	
	@Transactional
	public int increaseFailCount(MemberLock loginUserLock) {
		
		return memberDao.increaseFailCount(sqlSession, loginUserLock);
	}
	
	@Transactional
	public int lockAccount(int userNo) {
		
		return memberDao.lockAccount(sqlSession, userNo);
	}
	
	@Transactional
	public int resetFailCount(MemberLock ml) {
		
		return memberDao.resetFailCount(sqlSession, ml);
	}
    
   
	
	
	
	
	
}
