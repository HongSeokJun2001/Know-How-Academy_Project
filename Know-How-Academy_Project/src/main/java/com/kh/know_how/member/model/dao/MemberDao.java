package com.kh.know_how.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.member.model.vo.Member;
import com.kh.know_how.member.model.vo.MemberLock;

@Repository
public class MemberDao {
    
	public Member loginMember(SqlSessionTemplate sqlSession, String userId) {
		
		return sqlSession.selectOne("memberMapper.loginMember", userId);
	}
	
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.insert("memberMapper.insertMember", m);
	}
	
	public int insertMemberLock(SqlSessionTemplate sqlSession, int userNo) {
		
		return sqlSession.update("memberMapper.insertMemberLock", userNo);
	}
	
    public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.update("memberMapper.updateMember", m);
	}
    
    public int updatePwd(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.update("memberMapper.updatePwd", m);
	}
    
    public Member searchId(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.selectOne("memberMapper.searchId", m);
	}
    
    public Member searchPassword(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.selectOne("memberMapper.searchPassword", m);
	}
    
    public int deleteMember(SqlSessionTemplate sqlSession, String userId) {
		
		return sqlSession.update("memberMapper.deleteMember", userId);
	}
	
	public int idCheck(SqlSessionTemplate sqlSession, String checkId) {
		
		return sqlSession.selectOne("memberMapper.idCheck", checkId);
	}
	
    public int emailCheck(SqlSessionTemplate sqlSession, String checkEmail) {
		
		return sqlSession.selectOne("memberMapper.emailCheck", checkEmail);
	}

	public MemberLock loginLockMember(SqlSessionTemplate sqlSession, int userNo) {

		return sqlSession.selectOne("memberMapper.loginLockMember", userNo);
	}
	
    public int increaseFailCount(SqlSessionTemplate sqlSession, MemberLock loginUserLock) {
		
		return sqlSession.update("memberMapper.increaseFailCount", loginUserLock);
	}

	public int lockAccount(SqlSessionTemplate sqlSession, int userNo) {
		
		return sqlSession.update("memberMapper.lockAccount", userNo);
	}

	public int resetFailCount(SqlSessionTemplate sqlSession, MemberLock ml) {
		
		return sqlSession.update("memberMapper.resetFailCount", ml);
	}

}
    
    
    
    
