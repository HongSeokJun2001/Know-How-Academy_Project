package com.kh.know_how.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.member.model.vo.Member;

@Repository
public class MemberDao {
    
	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.selectOne("memberMapper.loginMember",m);
	}
	
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.insert("memberMapper.insertMember", m);
	}
	
    public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.update("memberMapper.updateMember", m);
	}
    
    public int updatePwd(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.update("memberMapper.updatePwd", m);
	}
    
    public int searchId(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.insert("memberMapper.searchId", m);
	}
    
    public int searchPassword(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.insert("memberMapper.searchPassword", m);
	}
    
    public int deleteMember(SqlSessionTemplate sqlSession, String userId) {
		
		return sqlSession.update("memberMapper.deleteMember", userId);
	}
	
	public int idCheck(SqlSessionTemplate sqlSession, String checkId) {
		
		return sqlSession.selectOne("memberMapper.idCheck", checkId);
	}
	
}
