<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Top-up - ZZZ Archive</title>
    
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
        /* Cắt góc thẻ */
        .clip-card { 
            clip-path: polygon(10% 0, 100% 0, 100% 100%, 0 100%, 0 20%); 
        }
        /* Thanh cuộn */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #222831; }
        ::-webkit-scrollbar-thumb { background: #393E46; border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: #F96D00; }
    </style>
</head>
<body class="bg-zzz-base text-zzz-text font-mono h-screen flex flex-col bg-grid selection:bg-zzz-accent selection:text-white">

    <nav class="bg-zzz-base/95 backdrop-blur-md border-b border-zzz-card p-4 sticky top-0 z-50 shadow-md">
        <div class="max-w-6xl mx-auto flex justify-between items-center">
            <a href="home" class="flex items-center gap-2 text-lg font-black italic tracking-tighter group text-gray-400 hover:text-zzz-text transition-colors">
                <div class="w-8 h-8 bg-zzz-card rounded flex items-center justify-center group-hover:bg-zzz-accent transition-colors">
                    <i class="fa-solid fa-reply text-sm text-white"></i>
                </div>
                <span>BACK TO SHOP</span>
            </a>
            <div class="text-zzz-accent font-black text-xl tracking-widest border-r-4 border-zzz-accent pr-4 uppercase">
                /// POLYCHROME MARKET
            </div>
        </div>
    </nav>

    <div class="flex-1 overflow-y-auto p-8 flex justify-center items-center">
        <div class="w-full max-w-6xl">
            
            <% 
                User u = (User) session.getAttribute("acc"); 
                if(u == null) { 
                    response.sendRedirect("login"); 
                    return; 
                } 
            %>
            <div class="text-center mb-12">
                <h2 class="text-gray-400 text-sm font-bold uppercase tracking-[0.3em] mb-4">Current Balance</h2>
                <div class="inline-block bg-zzz-card border-2 border-zzz-accent px-8 py-4 rounded-lg shadow-[0_0_20px_rgba(249,109,0,0.3)] transform hover:scale-105 transition-transform">
                    <div class="text-6xl font-black text-white flex justify-center items-center gap-4">
                        <i class="fa-solid fa-gem text-zzz-accent animate-pulse text-4xl"></i>
                        <%= String.format("%,.0f", u.getBalance()) %>
                    </div>
                </div>
                
                <% if(request.getAttribute("success") != null) { %>
                    <div class="mt-6 bg-green-900/30 border border-green-500 text-green-400 px-6 py-2 inline-block rounded font-bold uppercase tracking-widest animate-bounce">
                        <i class="fa-solid fa-check mr-2"></i> <%= request.getAttribute("success") %>
                    </div>
                <% } %>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                
                <form action="deposit-confirm" method="POST" class="group cursor-pointer h-full">
                    <input type="hidden" name="amount" value="60">
                    <button type="submit" class="w-full h-full bg-zzz-card border-2 border-gray-600 hover:border-zzz-accent p-8 relative overflow-hidden transition-all hover:-translate-y-2 clip-card shadow-lg text-left group-hover:shadow-[0_0_20px_rgba(249,109,0,0.2)]">
                        <div class="absolute inset-0 bg-zzz-accent opacity-0 group-hover:opacity-5 transition-opacity"></div>
                        
                        <div class="flex justify-between items-start mb-6">
                            <i class="fa-solid fa-layer-group text-5xl text-gray-500 group-hover:text-zzz-accent transition-colors"></i>
                            <span class="bg-zzz-base text-gray-400 text-[10px] px-2 py-1 font-bold border border-gray-600 rounded">BASIC</span>
                        </div>
                        
                        <h3 class="text-3xl font-black text-white mb-1">60 POLY</h3>
                        <p class="text-gray-400 text-xs font-bold">+ Bonus: 0</p>
                        
                        <div class="mt-8 bg-zzz-base py-3 px-4 font-black text-zzz-accent border border-gray-600 group-hover:bg-zzz-accent group-hover:text-white group-hover:border-zzz-accent transition-colors text-center tracking-widest text-lg">
                            $0.99
                        </div>
                    </button>
                </form>

                <form action="deposit-confirm" method="POST" class="group cursor-pointer h-full">
                    <input type="hidden" name="amount" value="300">
                    <button type="submit" class="w-full h-full bg-zzz-card border-2 border-gray-600 hover:border-zzz-accent p-8 relative overflow-hidden transition-all hover:-translate-y-2 clip-card shadow-lg text-left group-hover:shadow-[0_0_20px_rgba(249,109,0,0.2)]">
                        <div class="absolute inset-0 bg-zzz-accent opacity-0 group-hover:opacity-5 transition-opacity"></div>
                        <div class="absolute top-0 right-0 bg-zzz-accent text-zzz-base text-[10px] font-black px-3 py-1">POPULAR</div>
                        
                        <div class="flex justify-between items-start mb-6">
                            <i class="fa-solid fa-cubes-stacked text-5xl text-gray-500 group-hover:text-zzz-accent transition-colors"></i>
                            <span class="bg-zzz-base text-gray-400 text-[10px] px-2 py-1 font-bold border border-gray-600 rounded mt-6">STANDARD</span>
                        </div>

                        <h3 class="text-3xl font-black text-white mb-1">300 POLY</h3>
                        <p class="text-gray-400 text-xs font-bold">+ Bonus: 30</p>
                        
                        <div class="mt-8 bg-zzz-base py-3 px-4 font-black text-zzz-accent border border-gray-600 group-hover:bg-zzz-accent group-hover:text-white group-hover:border-zzz-accent transition-colors text-center tracking-widest text-lg">
                            $4.99
                        </div>
                    </button>
                </form>

                <form action="deposit-confirm" method="POST" class="group cursor-pointer h-full">
                    <input type="hidden" name="amount" value="980">
                    <button type="submit" class="w-full h-full bg-zzz-card border-2 border-gray-600 hover:border-zzz-accent p-8 relative overflow-hidden transition-all hover:-translate-y-2 clip-card shadow-lg text-left group-hover:shadow-[0_0_20px_rgba(249,109,0,0.2)]">
                        <div class="absolute inset-0 bg-zzz-accent opacity-0 group-hover:opacity-5 transition-opacity"></div>
                        <div class="absolute top-0 right-0 bg-purple-500 text-white text-[10px] font-black px-3 py-1">BEST VALUE</div>
                        
                        <div class="flex justify-between items-start mb-6">
                            <i class="fa-solid fa-box-open text-5xl text-gray-500 group-hover:text-zzz-accent transition-colors"></i>
                            <span class="bg-zzz-base text-gray-400 text-[10px] px-2 py-1 font-bold border border-gray-600 rounded mt-6">PREMIUM</span>
                        </div>

                        <h3 class="text-3xl font-black text-white mb-1">980 POLY</h3>
                        <p class="text-gray-400 text-xs font-bold">+ Bonus: 110</p>
                        
                        <div class="mt-8 bg-zzz-base py-3 px-4 font-black text-zzz-accent border border-gray-600 group-hover:bg-zzz-accent group-hover:text-white group-hover:border-zzz-accent transition-colors text-center tracking-widest text-lg">
                            $14.99
                        </div>
                    </button>
                </form>
                
                <form action="deposit-confirm" method="POST" class="group cursor-pointer md:col-span-3 mt-4">
                    <input type="hidden" name="amount" value="5000">
                    <button type="submit" class="w-full bg-zzz-base border-2 border-dashed border-gray-700 hover:border-green-500 p-4 relative overflow-hidden transition-all opacity-50 hover:opacity-100 hover:bg-green-900/20">
                        <div class="flex items-center justify-center gap-3">
                            <i class="fa-solid fa-terminal text-green-500"></i>
                            <span class="text-green-500 font-bold font-mono tracking-widest">/// DEV MODE: ADD 5000 FREE POLYCHROME ///</span>
                        </div>
                    </button>
                </form>

            </div>
        </div>
    </div>

</body>
</html>