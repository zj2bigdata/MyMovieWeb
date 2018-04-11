package sun.moviemgr.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sun.moviemgr.dao.TicketMapper;
import sun.moviemgr.pojo.Ticket;

@Service
public class TicketDaoImpl {
		@Resource
		private TicketMapper ticketMapper;
		@Transactional(readOnly=true)
		public Ticket findByTicketId(String id){
			return ticketMapper.findByTicketId(id);
		}
}
