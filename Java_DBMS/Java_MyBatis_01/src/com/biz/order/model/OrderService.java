package com.biz.order.model;

import java.util.List;

public interface OrderService {
	public List<OrderVO> selectAll();
	public OrderVO findBySeq(long seq);
	
	public int insert(OrderVO orderVO);
	public int update(OrderVO orderVO);
	
	public int delete(long seq);
	

}
