package com.ycft.ycft.mapper;

import java.util.List;

import com.ycft.ycft.po.Comment;
import com.ycft.ycft.po.Forum;

public interface CommentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Comment record);

    int insertSelective(Comment record);

    Comment selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Comment record);

    int updateByPrimaryKeyWithBLOBs(Comment record);

    int updateByPrimaryKey(Comment record);
    
    public List<Comment> selComment(Integer id);
    /*
	 * 服务端方法开始
	 * 
	 * */
    public int updateCommentRestore(int id);
    /*
	 * 服务端方法结束
	 * 
	 * */
}