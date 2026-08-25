<%@page import="model.Order"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Transaction Log - ZZZ Archive</title>
    
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
                        mono: ['Courier New', 'Courier', 'monospace'],
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
        
        /* Hiệu ứng CRT mờ */
        .crt-overlay {
            background: linear-gradient(rgba(34, 40, 49, 0) 50%, rgba(0, 0, 0, 0.1) 50%);
            background-size: 100% 4px; pointer-events: none; position: fixed; inset: 0; z-index: 50;
        }
    </style>
</head>
<body class="bg-zzz-base text-zzz-text font-mono h-screen flex flex-col bg-grid selection:bg-zzz-accent selection:text-white">

    <div class="crt-overlay"></div>

    <nav class="bg-zzz-base/95 backdrop-blur-md border-b border-zzz-card p-4 sticky top-0 z-40 shadow-md">
        <div class="max-w-5xl mx-auto flex justify-between items-center">
            <a href="home" class="flex items-center gap-2 text-lg font-black italic tracking-tighter group text-gray-400 hover:text-zzz-text transition-colors">
                <div class="w-8 h-8 bg-zzz-card rounded flex items-center justify-center group-hover:bg-zzz-accent transition-colors">
                    <i class="fa-solid fa-reply text-sm text-white"></i>
                </div>
                <span>BACK TO BASE</span>
            </a>
            <div class="text-zzz-accent font-black text-xl tracking-widest border-r-4 border-zzz-accent pr-4 uppercase">
                /// TRANSACTION LOG
            </div>
        </div>
    </nav>

    <div class="flex-1 overflow-y-auto p-4 md:p-8 flex justify-center relative z-10">
        <div class="w-full max-w-5xl">
            
            <div class="flex items-center gap-4 mb-8 border-b border-gray-700 pb-4">
                <div class="w-2 h-12 bg-zzz-accent"></div>
                <div>
                    <h2 class="text-3xl font-black uppercase tracking-tighter text-zzz-text">Mission History</h2>
                    <p class="text-xs text-gray-500 font-bold uppercase tracking-wide">Recorded supply requests from Hollow Database.</p>
                </div>
            </div>

            <div class="space-y-4 pb-10">
                <%
                    List<Order> list = (List<Order>) request.getAttribute("listOrders");
                    
                    if (list != null && !list.isEmpty()) {
                        for (Order o : list) {
                %>
                
                <a href="order-detail?id=<%= o.getId() %>" class="block group">
                    <div class="bg-zzz-card border border-gray-600 p-6 flex flex-col md:flex-row items-center justify-between hover:border-zzz-accent transition-all relative overflow-hidden shadow-lg hover:shadow-[0_0_15px_rgba(249,109,0,0.2)] rounded-sm">
                        
                        <div class="absolute right-4 top-1/2 -translate-y-1/2 text-gray-600 group-hover:text-zzz-accent group-hover:translate-x-1 transition-all text-2xl">
                            <i class="fa-solid fa-chevron-right"></i>
                        </div>

                        <div class="absolute -right-6 -top-6 text-8xl text-black opacity-20 font-black italic select-none pointer-events-none">LOG</div>
                        
                        <div class="flex items-center gap-6 z-10 w-full md:w-auto mb-4 md:mb-0 border-b md:border-b-0 border-gray-600 pb-4 md:pb-0">
                            <div class="bg-zzz-base w-16 h-16 flex flex-col items-center justify-center border border-gray-500 rounded group-hover:border-zzz-accent transition-colors">
                                <span class="text-[9px] text-gray-500 font-bold">ID</span>
                                <span class="text-xl font-black text-white">#<%= o.getId() %></span>
                            </div>
                            <div>
                                <div class="text-zzz-accent text-[10px] font-black uppercase tracking-widest mb-1 flex items-center gap-1">
                                    <i class="fa-regular fa-calendar"></i> Date Recorded
                                </div>
                                <div class="text-lg font-bold text-zzz-text"><%= o.getDate() %></div>
                            </div>
                        </div>

                        <div class="bg-green-900/30 px-4 py-1 rounded border border-green-500/50 text-green-400 font-bold text-xs uppercase tracking-widest flex items-center gap-2">
                            <i class="fa-solid fa-check-circle"></i> Completed
                        </div>

                        <div class="text-right z-10 w-full md:w-auto mt-4 md:mt-0 pr-10">
                            <div class="text-[10px] text-gray-400 uppercase font-bold tracking-wider">Total Amount</div>
                            <div class="text-2xl font-black text-zzz-accent font-mono flex items-center justify-end gap-2">
                                <i class="fa-solid fa-bolt text-sm animate-pulse"></i>
                                <%= String.format("%,.0f", o.getTotalMoney()) %> 
                                <span class="text-[10px] text-gray-500 font-sans font-bold pt-2">POLY</span>
                            </div>
                        </div>
                    </div>
                </a>

                <% 
                        }
                    } else { 
                %>
                    <div class="text-center py-24 border-2 border-dashed border-gray-700 bg-zzz-card/30 rounded flex flex-col items-center justify-center">
                        <div class="w-20 h-20 bg-zzz-base rounded-full flex items-center justify-center border-2 border-gray-600 mb-4">
                            <i class="fa-solid fa-file-circle-xmark text-4xl text-gray-500"></i>
                        </div>
                        <h3 class="text-xl font-black text-gray-400 uppercase tracking-widest">No Records Found</h3>
                        <p class="text-gray-600 mt-2 text-sm">You haven't made any supply requests yet.</p>
                        <a href="home" class="mt-6 text-zzz-accent hover:text-white underline text-sm font-bold uppercase">Start a new commission</a>
                    </div>
                <% } %>
            </div>

        </div>
    </div>

</body>
</html>