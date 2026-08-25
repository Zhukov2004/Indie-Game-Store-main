<%@page import="model.Cart"%>
<%@page import="model.Item"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart - ZZZ Archive</title>
    
    <script src="https://cdn.tailwindcss.com"></script>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        zzz: {
                            base: '#222831',    // Navy Đậm
                            card: '#393E46',    // Xám Navy
                            accent: '#F96D00',  // Cam Cháy
                            text: '#F2F2F2'     // Trắng Xám
                        }
                    },
                    fontFamily: {
                        mono: ['Courier New', 'monospace']
                    }
                }
            }
        }
    </script>

    <style>
        /* Hiệu ứng nền lưới */
        .bg-grid { 
            background-image: radial-gradient(#393E46 1px, transparent 1px); 
            background-size: 20px 20px; 
        }
        /* Tùy chỉnh thanh cuộn */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #222831; }
        ::-webkit-scrollbar-thumb { background: #393E46; border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: #F96D00; }
    </style>
</head>
<body class="bg-zzz-base text-zzz-text font-mono h-screen flex flex-col bg-grid selection:bg-zzz-accent selection:text-white">

    <nav class="bg-zzz-base/95 backdrop-blur-md border-b border-zzz-card p-4 sticky top-0 z-50 shadow-md">
        <div class="max-w-7xl mx-auto flex justify-between items-center">
            <a href="home" class="flex items-center gap-2 text-lg font-black italic tracking-tighter group text-gray-400 hover:text-zzz-text transition-colors">
                <div class="w-8 h-8 bg-zzz-card rounded flex items-center justify-center group-hover:bg-zzz-accent transition-colors">
                    <i class="fa-solid fa-reply text-sm text-white"></i>
                </div>
                <span>BACK TO SHOP</span>
            </a>
            <div class="text-zzz-accent font-black text-xl tracking-widest border-r-4 border-zzz-accent pr-4">
                /// CART TERMINAL
            </div>
        </div>
    </nav>

    <div class="flex-1 overflow-y-auto p-4 md:p-8 flex justify-center">
        <div class="w-full max-w-6xl flex flex-col md:flex-row gap-8">
            
            <div class="flex-1">
                <h2 class="text-2xl font-black mb-6 flex items-center gap-3 text-zzz-text uppercase tracking-tighter border-b border-zzz-card pb-2">
                    <i class="fa-solid fa-layer-group text-zzz-accent"></i>
                    Selected Signals
                </h2>

                <%
                    // Lấy giỏ hàng từ Session
                    Cart cart = (Cart) session.getAttribute("cart");
                    
                    if (cart != null && cart.getItems().size() > 0) {
                        for (Item i : cart.getItems()) {
                %>
                
                <div class="bg-zzz-card border border-gray-600 p-4 mb-4 flex items-center gap-4 rounded-sm shadow-lg hover:border-zzz-accent transition-all group relative overflow-hidden">
                    
                    <div class="absolute inset-0 bg-zzz-accent opacity-0 group-hover:opacity-5 transition-opacity pointer-events-none"></div>

                    <div class="w-24 h-24 bg-zzz-base border border-gray-500 flex-shrink-0 relative overflow-hidden">
                        <img src="images/<%= i.getProduct().getImage() %>" 
                             class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" 
                             onerror="this.src='https://placehold.co/100x100/222/FFF?text=ERR'">
                        
                        <span class="absolute top-0 left-0 bg-black/90 text-[9px] px-1.5 py-0.5 font-bold text-white border-b border-r border-gray-600">
                            <%= i.getProduct().getRarity() %>
                        </span>
                    </div>
                    
                    <div class="flex-1 min-w-0">
                        <h3 class="text-lg md:text-xl font-black uppercase text-white truncate"><%= i.getProduct().getName() %></h3>
                        <p class="text-xs text-gray-400 mb-2 tracking-wide uppercase"><%= i.getProduct().getType() %></p>
                        <div class="text-zzz-accent font-mono font-bold flex items-center gap-1">
                            <i class="fa-solid fa-bolt text-xs"></i>
                            <%= String.format("%,.0f", i.getPrice()) %>
                        </div>
                    </div>

                    <div class="flex flex-col items-center mx-2 md:mx-4 bg-zzz-base border border-gray-600 p-2 rounded">
                        <div class="text-[9px] text-gray-500 uppercase font-bold">QTY</div>
                        <div class="text-xl font-black text-white"><%= i.getQuantity() %></div>
                    </div>

                    <a href="cart?action=delete&id=<%= i.getProduct().getId() %>" 
                       class="w-10 h-10 rounded bg-zzz-base border border-gray-600 text-gray-400 flex items-center justify-center hover:bg-red-600 hover:text-white hover:border-red-600 transition-all z-10"
                       onclick="return confirm('Delete this signal data?')"
                       title="Remove Item">
                        <i class="fa-solid fa-trash"></i>
                    </a>
                </div>
                
                <% 
                        }
                    } else { 
                %>
                    <div class="text-center py-24 border-2 border-dashed border-gray-700 rounded-lg bg-zzz-card/30">
                        <i class="fa-solid fa-satellite-dish text-7xl text-gray-600 mb-6 animate-pulse"></i>
                        <h3 class="text-xl font-bold text-gray-400 uppercase">No Signal Detected</h3>
                        <p class="text-gray-600 text-sm mt-2">Your cart is currently empty.</p>
                        <a href="home" class="inline-block mt-8 px-8 py-3 bg-zzz-base border border-zzz-accent text-zzz-accent font-bold uppercase tracking-wider hover:bg-zzz-accent hover:text-white transition-all shadow-lg">
                            Start Search
                        </a>
                    </div>
                <% } %>
            </div>

            <div class="w-full md:w-80 flex-shrink-0">
                <div class="bg-zzz-card border-t-4 border-zzz-accent p-6 sticky top-24 shadow-2xl rounded-b-lg">
                    <h3 class="text-xl font-black uppercase mb-6 border-b border-gray-600 pb-4 tracking-tighter">
                        Order Summary
                    </h3>
                    
                    <div class="space-y-3 mb-8">
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-400">Total Quantity:</span>
                            <span class="font-bold text-white"><%= (cart!=null) ? cart.getTotalQuantity() : 0 %></span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-400">Tax (New Eridu):</span>
                            <span class="font-bold text-white">0%</span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-400">Shipping:</span>
                            <span class="font-bold text-zzz-accent">Hollow Channel (Free)</span>
                        </div>
                    </div>

                    <div class="flex justify-between items-end mb-8 border-t border-gray-600 pt-4">
                        <span class="font-black text-lg text-white">TOTAL:</span>
                        <div class="text-right">
                            <div class="text-3xl font-black text-zzz-accent font-mono leading-none">
                                <%= (cart!=null) ? String.format("%,.0f", cart.getTotalMoney()) : 0 %>
                            </div>
                            <div class="text-[10px] text-gray-500 mt-1 font-bold tracking-widest">POLYCHROME</div>
                        </div>
                    </div>

                    <% if (session.getAttribute("acc") == null) { %>
                        
                        <a href="login" class="block w-full bg-gray-600 text-center py-4 font-black text-gray-300 hover:bg-gray-500 transition-colors mb-2 skew-x-[-5deg]">
                            <div class="skew-x-[5deg]">LOGIN TO PURCHASE</div>
                        </a>
                        <p class="text-[10px] text-center text-red-400 font-bold uppercase">
                            <i class="fa-solid fa-lock mr-1"></i> Proxy authentication required
                        </p>

                    <% } else if (cart != null && cart.getItems().size() > 0) { %>
                        
                        <form action="checkout" method="POST">
                            <button type="submit" 
                                    onclick="return confirm('Confirm supply request transaction?')"
                                    class="block w-full bg-zzz-accent hover:bg-white hover:text-zzz-accent text-white text-center py-4 font-black uppercase tracking-widest transition-all shadow-[0_0_20px_rgba(249,109,0,0.5)] skew-x-[-5deg] hover:skew-x-0 group">
                                <div class="skew-x-[5deg] group-hover:skew-x-0 flex items-center justify-center gap-2">
                                    REQUEST SUPPLY <i class="fa-solid fa-arrow-right"></i>
                                </div>
                            </button>
                        </form>
                        <p class="text-[10px] text-center text-gray-500 mt-3">
                            *Transaction cannot be refunded after signal transmission.
                        </p>

                    <% } else { %>
                        
                        <button class="block w-full bg-zzz-base border border-gray-600 text-gray-500 text-center py-4 font-black uppercase cursor-not-allowed skew-x-[-5deg]">
                            <div class="skew-x-[5deg]">EMPTY CART</div>
                        </button>

                    <% } %>
                </div>
            </div>

        </div>
    </div>

</body>
</html>