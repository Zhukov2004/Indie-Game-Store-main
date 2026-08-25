<%@page import="model.Item"%>
<%@page import="model.Order"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Order Detail - ZZZ</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: { colors: { zzz: { base: '#222831', card: '#393E46', accent: '#F96D00', text: '#F2F2F2' } } }
            }
        }
    </script>
    <style>
        .bg-grid { background-image: radial-gradient(#393E46 1px, transparent 1px); background-size: 20px 20px; }
    </style>
</head>
<body class="bg-zzz-base text-zzz-text font-mono h-screen flex flex-col bg-grid">

    <%
        Order order = (Order) request.getAttribute("order");
        List<Item> details = (List<Item>) request.getAttribute("details");
        if(order == null) response.sendRedirect("history");
    %>

    <nav class="bg-zzz-base/95 backdrop-blur-md border-b border-zzz-card p-4 sticky top-0 z-50">
        <div class="max-w-4xl mx-auto flex justify-between items-center">
            <a href="history" class="flex items-center gap-2 text-lg font-black italic tracking-tighter group text-gray-400 hover:text-zzz-text transition-colors">
                <i class="fa-solid fa-arrow-left text-zzz-accent"></i> BACK TO LOGS
            </a>
            <div class="text-zzz-accent font-black text-xl tracking-widest border-r-4 border-zzz-accent pr-4">
                /// INVOICE #<%= order.getId() %>
            </div>
        </div>
    </nav>

    <div class="flex-1 overflow-y-auto p-8 flex justify-center">
        <div class="w-full max-w-4xl">
            
            <div class="bg-zzz-card border-t-4 border-zzz-accent p-6 mb-6 shadow-xl relative overflow-hidden">
                <div class="flex justify-between items-start relative z-10">
                    <div>
                        <h2 class="text-xs text-gray-400 uppercase font-bold mb-1">Commission Date</h2>
                        <p class="text-2xl font-black text-white"><%= order.getDate() %></p>
                    </div>
                    <div class="text-right">
                        <h2 class="text-xs text-gray-400 uppercase font-bold mb-1">Status</h2>
                        <span class="bg-green-500/20 text-green-400 px-3 py-1 rounded text-xs font-black uppercase border border-green-500/50">
                            Success
                        </span>
                    </div>
                </div>
                <i class="fa-solid fa-file-invoice text-9xl absolute -bottom-4 -right-4 text-black opacity-10 z-0"></i>
            </div>

            <div class="bg-zzz-base border border-gray-700 p-6 rounded shadow-lg">
                <h3 class="text-xl font-black uppercase mb-6 flex items-center gap-2 border-b border-gray-700 pb-4">
                    <i class="fa-solid fa-box-open text-zzz-accent"></i> Supply List
                </h3>

                <div class="space-y-4">
                    <% 
                    if (details != null) {
                        for(Item i : details) { 
                    %>
                    <div class="flex items-center gap-4 p-3 bg-zzz-card/50 rounded border border-transparent hover:border-gray-600 transition-colors">
                        <div class="w-16 h-16 bg-black border border-gray-600 flex-shrink-0 relative">
                            <img src="images/<%= i.getProduct().getImage() %>" class="w-full h-full object-cover">
                            <span class="absolute bottom-0 right-0 bg-zzz-accent text-black text-[9px] px-1 font-bold">
                                x<%= i.getQuantity() %>
                            </span>
                        </div>
                        
                        <div class="flex-1">
                            <h4 class="font-black uppercase text-lg text-white"><%= i.getProduct().getName() %></h4>
                            <span class="text-xs text-gray-500 bg-black px-2 py-0.5 rounded"><%= i.getProduct().getRarity() %></span>
                        </div>

                        <div class="text-right">
                            <div class="text-xs text-gray-500">Unit Price</div>
                            <div class="font-mono font-bold text-zzz-accent"><%= String.format("%,.0f", i.getPrice()) %></div>
                        </div>
                        
                        <div class="text-right w-32 border-l border-gray-700 pl-4">
                            <div class="text-xs text-gray-500">Subtotal</div>
                            <div class="font-mono font-black text-white text-lg"><%= String.format("%,.0f", i.getPrice() * i.getQuantity()) %></div>
                        </div>
                    </div>
                    <% 
                        } 
                    } 
                    %>
                </div>

                <div class="mt-8 pt-6 border-t border-gray-600 flex justify-end items-center gap-4">
                    <span class="text-gray-400 uppercase font-bold text-sm">Total Payment</span>
                    <div class="text-4xl font-black text-zzz-accent font-mono">
                        <%= String.format("%,.0f", order.getTotalMoney()) %>
                        <span class="text-sm text-gray-500">POLY</span>
                    </div>
                </div>
            </div>

        </div>
    </div>

</body>
</html>