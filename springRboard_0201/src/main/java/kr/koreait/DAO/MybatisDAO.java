package kr.koreait.DAO;

import java.util.ArrayList;
import java.util.HashMap;

import kr.koreait.VO.RboardCommentVO;
import kr.koreait.VO.RboardVO;

public interface MybatisDAO {
	public abstract void insert(RboardVO vo);
	public abstract int selectCount();
	public abstract ArrayList<RboardVO> selectList(HashMap<String, Integer> hmap);
	public abstract void increment(int idx);
	public abstract RboardVO selectByIdx(int idx);
	public abstract void delete(int idx);
	public abstract void update(RboardVO vo);
	public abstract void replyIncrement(HashMap<String, Integer> hmap);
	public abstract void replyInsert(RboardVO vo);
	public abstract ArrayList<RboardVO> selectNotice();
	
	public abstract void insertComment(RboardCommentVO cmvo);
	public abstract ArrayList<RboardCommentVO> selectCommentList(int idx);
	public abstract int replyCount(int idx);
	public abstract boolean updateComment(RboardCommentVO cmvo);
	public abstract RboardCommentVO selectCommentByIdx(int idx);
	public abstract void deleteComment(RboardCommentVO cmvo);
	
}
