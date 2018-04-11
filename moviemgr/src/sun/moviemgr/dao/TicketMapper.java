package sun.moviemgr.dao;

import org.springframework.stereotype.Repository;

import sun.moviemgr.pojo.Ticket;
@Repository
public interface TicketMapper {
	Ticket findByTicketId(String id);
}
