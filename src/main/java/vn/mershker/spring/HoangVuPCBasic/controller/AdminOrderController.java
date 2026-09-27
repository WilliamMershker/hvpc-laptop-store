package vn.mershker.spring.HoangVuPCBasic.controller;

import org.springframework.dao.DataIntegrityViolationException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.mershker.spring.HoangVuPCBasic.domain.Order;

import vn.mershker.spring.HoangVuPCBasic.service.OrderService;


@Controller
@RequestMapping("/admin/order")
public class AdminOrderController
{
    private final OrderService orderService;

    public AdminOrderController(OrderService orderService)
    {
        this.orderService = orderService;
    }

    // ==========================================
    // DANH SÁCH ORDER
    // ==========================================

    @GetMapping
    public String showOrders(Model model)
    {
        model.addAttribute("orders", orderService.getAllOrders());
        return "admin/order/show";
    }

    // ==========================================
    // CHI TIẾT ORDER
    // ==========================================

    @GetMapping("/{id}")
    public String orderDetail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes)
    {
        try
        {
            Order order = orderService.getOrderById(id);
            model.addAttribute("order", order);
            model.addAttribute("orderDetails", orderService.getOrderDetails(id));
            return "admin/order/detail";
        }
        catch (IllegalArgumentException e)
        {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/order";
        }
    }

    // ==========================================
    // UPDATE STATUS
    // ==========================================

    @PostMapping("/{id}/status")
    public String updateStatus(@PathVariable Long id, @RequestParam String status, RedirectAttributes redirectAttributes)
    {
        try
        {
            orderService.updateOrderStatus(id, status);

            redirectAttributes.addFlashAttribute("success", "Cập nhật trạng thái đơn hàng thành công.");
        }
        catch (IllegalArgumentException | IllegalStateException e)
        {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/admin/order/" + id;
    }


    // ==========================================
    // DELETE ORDER
    // ADMIN ONLY
    // ==========================================

    @PostMapping("/delete/{id}")
    public String deleteOrder(@PathVariable Long id, RedirectAttributes redirectAttributes)
    {
        try
        {
            orderService.deleteOrder(id);

            redirectAttributes.addFlashAttribute(
                            "success",
                            "Đã xóa lịch sử đơn hàng #"
                                    + id
                                    + " thành công."
                    );
        }
        catch (DataIntegrityViolationException e)
        {
            redirectAttributes
                    .addFlashAttribute(
                            "error",
                            "Không thể xóa đơn hàng vì vẫn còn dữ liệu liên quan."
                    );
        }
        catch (IllegalArgumentException |
               IllegalStateException e)
        {
            redirectAttributes
                    .addFlashAttribute(
                            "error",
                            e.getMessage()
                    );
        }


        return "redirect:/admin/order";
    }
}