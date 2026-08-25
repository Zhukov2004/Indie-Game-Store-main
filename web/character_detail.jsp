<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Combat Data - ZZZ</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        zzz: { base: '#222831', card: '#393E46', accent: '#F96D00', text: '#F2F2F2' }
                    }
                }
            }
        }
    </script>
    <style>
        .bg-grid { background-image: radial-gradient(#393E46 1px, transparent 1px); background-size: 20px 20px; }
        .clip-notch { clip-path: polygon(0 0, 100% 0, 100% 85%, 95% 100%, 0 100%); }
    </style>
</head>

<% Product p = (Product) request.getAttribute("charDetail"); if(p == null) response.sendRedirect("home"); %>

<body class="bg-zzz-base text-zzz-text font-mono h-screen overflow-hidden flex relative bg-grid">

    <a href="javascript:history.back()" class="absolute top-8 left-8 z-50 w-12 h-12 bg-zzz-card border border-gray-600 flex items-center justify-center rounded hover:bg-zzz-accent hover:text-white transition-colors">
        <i class="fa-solid fa-reply"></i>
    </a>

    <div class="w-1/3 h-full relative border-r border-gray-700 bg-zzz-base">
        <div class="absolute top-0 left-0 w-full h-full bg-gradient-to-b from-transparent to-zzz-base z-10"></div>
        <img src="images/<%= p.getImage() %>" class="w-full h-full object-cover object-top opacity-80">
        <div class="absolute bottom-10 left-10 z-20">
            <h1 class="text-5xl font-black italic text-zzz-accent uppercase"><%= p.getName() %></h1>
            <p class="text-gray-400 mt-2 tracking-widest">COMBAT CONFIGURATION</p>
        </div>
    </div>

    <div class="flex-1 p-12 flex flex-col justify-center gap-10">
        
        <div class="relative">
            <div class="flex items-center gap-4 mb-4">
                <div class="w-2 h-8 bg-zzz-accent"></div>
                <h2 class="text-2xl font-bold uppercase">Best W-Engine</h2>
            </div>
            <div class="flex items-center gap-6 bg-zzz-card p-6 border border-gray-600 clip-notch hover:border-zzz-accent transition-colors group">
                <div class="w-32 h-32 bg-zzz-base border border-gray-500 flex items-center justify-center overflow-hidden relative">
                    <div class="absolute inset-0 bg-zzz-accent opacity-0 group-hover:opacity-10 transition-opacity"></div>
                    <img src="images/<%= p.getwEngineImage() %>" class="w-full h-full object-contain p-2" onerror="this.src='https://placehold.co/100?text=W-Engine'">
                </div>
                <div>
                    <div class="text-xs text-zzz-accent mb-1 uppercase tracking-widest">Recommended Equipment</div>
                    <h3 class="text-3xl font-black uppercase"><%= p.getwEngineName() %></h3>
                    <p class="text-gray-400 text-sm mt-2">Tăng cường khả năng tấn công và hiệu quả thuộc tính.</p>
                </div>
            </div>
        </div>

        <div>
            <div class="flex items-center gap-4 mb-4">
                <div class="w-2 h-8 bg-blue-500"></div>
                <h2 class="text-2xl font-bold uppercase">Squad Setup</h2>
            </div>
            <div class="grid grid-cols-3 gap-4">
                
                <div class="bg-zzz-card p-4 border border-zzz-accent text-center relative cursor-default shadow-[0_0_15px_rgba(249,109,0,0.1)]">
                    <div class="text-xs text-zzz-accent font-bold mb-2 uppercase">Leader</div>
                    <img src="images/<%= p.getImage() %>" class="w-24 h-24 rounded-full mx-auto object-cover border-2 border-white mb-2">
                    <div class="font-bold truncate"><%= p.getName() %></div>
                </div>

                <% if(p.getTeammate1Id() > 0) { %>
                    <a href="character-detail?id=<%= p.getTeammate1Id() %>" class="block bg-zzz-card p-4 border border-gray-600 text-center hover:border-white hover:bg-gray-700 transition-all group cursor-pointer">
                        <div class="text-xs text-gray-400 font-bold mb-2 uppercase group-hover:text-white">Teammate 01</div>
                        <img src="images/<%= p.getTeammate1() %>" class="w-24 h-24 rounded-full mx-auto object-cover border-2 border-gray-500 group-hover:border-white mb-2 grayscale group-hover:grayscale-0 transition-all" onerror="this.src='https://placehold.co/100?text=?'">
                        <div class="text-gray-300 text-xs font-bold group-hover:text-zzz-accent flex items-center justify-center gap-1">
                            VIEW INFO <i class="fa-solid fa-arrow-right -rotate-45 text-[10px]"></i>
                        </div>
                    </a>
                <% } else { %>
                    <div class="bg-zzz-card p-4 border border-gray-600 text-center opacity-50 cursor-not-allowed">
                        <div class="text-xs text-gray-500 font-bold mb-2 uppercase">Teammate 01</div>
                        <div class="w-24 h-24 rounded-full mx-auto bg-zzz-base border border-gray-700 mb-2 flex items-center justify-center">
                            <i class="fa-solid fa-user-slash text-2xl text-gray-600"></i>
                        </div>
                        <div class="text-gray-500 text-xs">Data Not Available</div>
                    </div>
                <% } %>

                <% if(p.getTeammate2Id() > 0) { %>
                    <a href="character-detail?id=<%= p.getTeammate2Id() %>" class="block bg-zzz-card p-4 border border-gray-600 text-center hover:border-white hover:bg-gray-700 transition-all group cursor-pointer">
                        <div class="text-xs text-gray-400 font-bold mb-2 uppercase group-hover:text-white">Teammate 02</div>
                        <img src="images/<%= p.getTeammate2() %>" class="w-24 h-24 rounded-full mx-auto object-cover border-2 border-gray-500 group-hover:border-white mb-2 grayscale group-hover:grayscale-0 transition-all" onerror="this.src='https://placehold.co/100?text=?'">
                        <div class="text-gray-300 text-xs font-bold group-hover:text-zzz-accent flex items-center justify-center gap-1">
                            VIEW INFO <i class="fa-solid fa-arrow-right -rotate-45 text-[10px]"></i>
                        </div>
                    </a>
                <% } else { %>
                    <div class="bg-zzz-card p-4 border border-gray-600 text-center opacity-50 cursor-not-allowed">
                        <div class="text-xs text-gray-500 font-bold mb-2 uppercase">Teammate 02</div>
                        <div class="w-24 h-24 rounded-full mx-auto bg-zzz-base border border-gray-700 mb-2 flex items-center justify-center">
                            <i class="fa-solid fa-user-slash text-2xl text-gray-600"></i>
                        </div>
                        <div class="text-gray-500 text-xs">Data Not Available</div>
                    </div>
                <% } %>

            </div>
            
            <% if(!p.isUpcoming()) { %>
            <div class="mt-8 pt-6 border-t border-gray-700 flex justify-end items-center gap-6">
                <div class="text-right">
                    <div class="text-xs text-gray-500 font-bold mb-1">UNIT PRICE</div>
                    <div class="text-3xl font-black text-zzz-accent font-mono"><%= String.format("%,.0f", p.getPrice()) %> <span class="text-sm">POLY</span></div>
                </div>
                <form action="cart" method="POST">
                    <input type="hidden" name="id" value="<%= p.getId() %>">
                    <input type="hidden" name="num" value="1">
                    <button type="submit" class="bg-zzz-text text-zzz-base px-8 py-3 font-black uppercase tracking-wider hover:bg-zzz-accent hover:text-white transition-all transform -skew-x-12 shadow-lg">
                        <span class="skew-x-12 flex items-center gap-2">TUNE SIGNAL <i class="fa-solid fa-signal"></i></span>
                    </button>
                </form>
            </div>
            <% } else { %>
                <div class="mt-8 pt-6 border-t border-gray-700 text-right">
                    <span class="bg-zzz-card text-gray-400 px-4 py-2 rounded font-bold border border-gray-600 cursor-not-allowed">
                        <i class="fa-solid fa-lock mr-2"></i> COMING SOON
                    </span>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>