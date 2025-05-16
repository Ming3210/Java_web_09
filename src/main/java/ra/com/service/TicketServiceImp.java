package ra.com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ra.com.model.Ticket;
import ra.com.repository.TicketRepository;

@Service
public class TicketServiceImp implements TicketService{
    @Autowired
    private TicketRepository ticketRepository;
    @Override
    public boolean addTicket(Ticket ticket) {
        return ticketRepository.addTicket(ticket);
    }
}
