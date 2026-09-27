package vn.mershker.spring.HoangVuPCBasic.service;

import org.springframework.stereotype.Service;

import org.springframework.web.context.annotation.SessionScope;

import vn.mershker.spring.HoangVuPCBasic.domain.Product;

import vn.mershker.spring.HoangVuPCBasic.dto.CartItem;

import java.math.BigDecimal;

import java.util.ArrayList;
import java.util.List;

@Service
@SessionScope
public class CartService
{
    private final List<CartItem> items = new ArrayList<>();

    public List<CartItem> getItems()
    {
        return items;
    }

    public void addProduct(Product product)
    {
        CartItem cartItem =
                findItem(
                        product.getId()
                );


        if (cartItem != null)
        {
            if (cartItem.getQuantity()
                    < product.getQuantity())
            {
                cartItem.setQuantity(
                        cartItem.getQuantity()
                                + 1
                );
            }

            return;
        }


        if (product.getQuantity() > 0)
        {
            items.add(
                    new CartItem(
                            product,
                            1
                    )
            );
        }
    }


    public void increase(
            Long productId)
    {
        CartItem item =
                findItem(
                        productId
                );


        if (item == null)
        {
            return;
        }


        if (item.getQuantity()
                < item.getProduct()
                .getQuantity())
        {
            item.setQuantity(
                    item.getQuantity()
                            + 1
            );
        }
    }


    public void decrease(
            Long productId)
    {
        CartItem item =
                findItem(
                        productId
                );


        if (item == null)
        {
            return;
        }


        if (item.getQuantity() <= 1)
        {
            items.remove(
                    item
            );
        }
        else
        {
            item.setQuantity(
                    item.getQuantity()
                            - 1
            );
        }
    }


    public void remove(
            Long productId)
    {
        items.removeIf(
                item ->
                        item.getProduct()
                                .getId()
                                .equals(
                                        productId
                                )
        );
    }


    public BigDecimal getTotalPrice()
    {
        return items
                .stream()
                .map(
                        CartItem::getSubtotal
                )
                .reduce(
                        BigDecimal.ZERO,
                        BigDecimal::add
                );
    }


    public boolean isEmpty()
    {
        return items.isEmpty();
    }


    public void clear()
    {
        items.clear();
    }


    private CartItem findItem(
            Long productId)
    {
        return items
                .stream()
                .filter(
                        item ->
                                item.getProduct()
                                        .getId()
                                        .equals(
                                                productId
                                        )
                )
                .findFirst()
                .orElse(null);
    }
}