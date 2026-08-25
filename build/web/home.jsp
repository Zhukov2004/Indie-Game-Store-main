<%@page import="model.GameUpdate"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="model.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Random Play - Signal Search</title>
    
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
                            text: '#F2F2F2',    // Trắng Xám
                            pink: '#ff0055', blue: '#00ccff'
                        }
                    },
                    fontFamily: { mono: ['Courier New', 'Courier', 'monospace'] }
                }
            }
        }
    </script>

    <style>
        .crt-overlay {
            background: linear-gradient(rgba(34, 40, 49, 0) 50%, rgba(0, 0, 0, 0.1) 50%);
            background-size: 100% 4px; pointer-events: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 50;
        }
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #222831; }
        ::-webkit-scrollbar-thumb { background: #393E46; border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: #F96D00; }
        
        .faction-watermark {
            mask-image: radial-gradient(circle, black 40%, transparent 80%);
            -webkit-mask-image: radial-gradient(circle, black 40%, transparent 80%);
            filter: grayscale(100%) brightness(0.7); mix-blend-mode: screen;
        }

        @keyframes marquee { 0% { transform: translateX(100%); } 100% { transform: translateX(-100%); } }
        .animate-marquee { display: inline-block; white-space: nowrap; animation: marquee 40s linear infinite; }
        .animate-marquee:hover { animation-play-state: paused; }
    </style>
</head>
<body class="bg-zzz-base text-zzz-text font-mono selection:bg-zzz-accent selection:text-white overflow-x-hidden relative">

    <div class="crt-overlay"></div>

    <nav class="sticky top-0 z-40 bg-zzz-base/95 backdrop-blur-md border-b border-zzz-card shadow-md">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-20">
                <div class="flex items-center gap-3">
                    <a href="home" class="flex items-center gap-2 group">
                        <img src="images/logo.png" alt="Logo" class="h-10 w-auto object-contain group-hover:opacity-80 transition-opacity" onerror="this.style.display='none'">
                        <span class="text-2xl font-black italic tracking-tighter text-zzz-text group-hover:text-zzz-accent transition-colors">/// RANDOM PLAY</span>
                    </a>
                </div>
                
                <div class="hidden md:block">
                    <div class="ml-10 flex items-baseline space-x-8">
                        <a href="home" class="text-zzz-accent font-bold px-3 py-2 rounded-md text-sm tracking-widest border-b-2 border-zzz-accent">HOME</a>
                        <a href="agents" class="text-zzz-text hover:text-zzz-accent px-3 py-2 rounded-md text-sm uppercase tracking-widest transition-colors flex items-center gap-2"><i class="fa-solid fa-users-viewfinder"></i> AGENTS</a>
                        <a href="#wengines-section" class="text-zzz-text hover:text-zzz-accent px-3 py-2 rounded-md text-sm uppercase tracking-widest transition-colors">W-ENGINES</a>
                    </div>
                </div>

                <div class="flex items-center gap-4">
                    
                    <div class="relative group hidden sm:block">
                        <input type="text" 
                               placeholder="SEARCH..." 
                               oninput="searchLive(this)"
                               class="bg-zzz-card border border-gray-600 rounded-full py-1 px-4 text-sm focus:outline-none focus:border-zzz-accent w-48 transition-all focus:w-64 text-zzz-text z-50 relative">
                        <i class="fa-solid fa-search absolute right-3 top-2 text-gray-500 group-hover:text-zzz-accent transition-colors z-50"></i>
                        
                        <div id="search-results" class="absolute top-10 left-0 w-full z-40 hidden">
                            </div>
                    </div>
                    
                    <a href="cart" class="relative p-2 hover:bg-zzz-card rounded-full transition-colors text-zzz-text group">
                        <i class="fa-solid fa-shopping-cart text-xl group-hover:text-zzz-accent"></i>
                        <% 
                            int totalQty = 0;
                            Cart c = (Cart) session.getAttribute("cart");
                            if (c != null) totalQty = c.getTotalQuantity();
                        %>
                        <% if(totalQty > 0) { %>
                            <span class="absolute -top-1 -right-1 bg-zzz-accent text-white text-[10px] font-bold rounded-full w-4 h-4 flex items-center justify-center"><%= totalQty %></span>
                        <% } %>
                    </a>

                    <% User u = (User) session.getAttribute("acc"); if (u != null) { %>
                        <div class="flex items-center gap-3 border-l border-gray-600 pl-4 ml-2">
                            <div class="text-right hidden sm:block">
                                <div class="text-[10px] text-zzz-accent font-bold flex items-center justify-end gap-1"><i class="fa-solid fa-gem"></i> <%= String.format("%,.0f", u.getBalance()) %></div>
                                <div class="text-white font-bold text-sm uppercase truncate max-w-[100px]"><%= u.getFullName() %></div>
                            </div>
                            <a href="deposit" class="bg-zzz-card hover:bg-green-600 text-white p-2 rounded text-xs font-bold transition-colors"><i class="fa-solid fa-plus"></i></a>
                            <% if (u.getRole() == 1) { %><a href="admin" class="bg-red-600 hover:bg-white hover:text-red-600 text-white p-2 rounded text-xs font-bold transition-colors shadow-[0_0_10px_red]"><i class="fa-solid fa-user-secret"></i></a><% } %>
                            <a href="history" class="bg-zzz-card hover:bg-zzz-accent text-white p-2 rounded text-xs font-bold transition-colors"><i class="fa-solid fa-clock-rotate-left"></i></a>
                            <a href="logout" class="bg-zzz-card hover:bg-red-600 text-white p-2 rounded text-xs font-bold transition-colors"><i class="fa-solid fa-power-off"></i></a>
                        </div>
                    <% } else { %>
                        <a href="login" class="bg-zzz-accent text-white px-4 py-1 font-bold uppercase text-xs hover:bg-white hover:text-zzz-accent transition-colors skew-x-[-10deg] ml-2 shadow-lg"><div class="skew-x-[10deg]">LOGIN</div></a>
                    <% } %>
                </div>
            </div>
        </div>
    </nav>

    <div class="bg-zzz-accent text-zzz-base overflow-hidden py-1 border-b border-zzz-card relative z-30 shadow-lg">
        <div class="animate-marquee font-bold text-xs tracking-widest uppercase flex gap-16">
            <% 
                List<GameUpdate> updates = (List<GameUpdate>) request.getAttribute("listNews");
                if (updates != null && !updates.isEmpty()) {
                    for(GameUpdate news : updates) {
            %>
                <a href="<%= news.getLink() %>" target="_blank" class="flex items-center gap-2 hover:text-white transition-colors">
                    <i class="fa-solid fa-bullhorn"></i> [<%= news.getVersion() %>] <%= news.getTitle() %> <span class="bg-black/20 px-1 rounded"><%= news.getDate() %></span> <i class="fa-solid fa-arrow-up-right-from-square text-[9px]"></i>
                </a>
            <% 
                    }
                } else {
            %>
                <span>/// SYSTEM NORMAL /// CONNECTION STABLE /// WELCOME PROXY ///</span>
            <% } %>
        </div>
    </div>

    <main class="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">

        <div class="flex flex-col lg:flex-row gap-6 mb-12">
            <div class="flex-1 relative overflow-hidden rounded-2xl border border-zzz-card group bg-zzz-base h-80 shadow-lg">
                <div class="h-full flex items-center justify-center relative overflow-hidden">
                    <div class="absolute top-0 right-0 w-64 h-64 bg-zzz-accent rounded-full blur-[120px] opacity-20"></div>
                    <div class="absolute bottom-0 left-0 w-64 h-64 bg-blue-600 rounded-full blur-[120px] opacity-10"></div>
                    <div class="text-center z-20 px-4">
                        <h1 class="text-4xl sm:text-6xl font-black italic uppercase mb-4 tracking-tighter text-zzz-text">NEW ERIDU <span class="text-zzz-accent inline-block transform -skew-x-12">ARCHIVE</span></h1>
                        <p class="text-gray-400 max-w-xl mx-auto text-sm">Welcome back, Proxy. The Hollow Zero investigation is ongoing.</p>
                    </div>
                </div>
                <div class="absolute bottom-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-zzz-accent to-transparent opacity-80"></div>
            </div>

            <div class="w-full lg:w-80 flex-shrink-0 bg-zzz-card border border-gray-600 rounded-2xl p-4 flex flex-col h-80 shadow-lg relative overflow-hidden">
                <div class="flex justify-between items-center mb-4 border-b border-gray-500 pb-2 z-10 relative">
                    <h3 class="text-zzz-accent font-black uppercase tracking-wider text-sm"><i class="fa-solid fa-list-check mr-2"></i> SYSTEM LOG</h3>
                    <a href="https://zenless.hoyoverse.com/en-us/news" target="_blank" class="text-[9px] text-gray-300 bg-zzz-base px-2 rounded border border-gray-600 hover:border-zzz-accent hover:text-zzz-accent transition-colors">VIEW ALL</a>
                </div>
                <div class="flex-1 overflow-y-auto pr-2 space-y-3 z-10 relative no-scrollbar">
                    <% if (updates != null) { for(GameUpdate news : updates) { 
                        String typeColor = "text-gray-400";
                        if(news.getType().equals("EVENT")) typeColor = "text-green-400"; else if(news.getType().equals("VERSION")) typeColor = "text-zzz-accent"; else if(news.getType().equals("MAINTENANCE")) typeColor = "text-red-400";
                    %>
                        <a href="<%= news.getLink() %>" target="_blank" class="block group cursor-pointer hover:bg-zzz-base/50 p-2 rounded transition-colors border border-transparent hover:border-gray-600">
                            <div class="flex justify-between text-[9px] text-gray-500 mb-1"><span class="<%= typeColor %> font-bold tracking-wide">[<%= news.getType() %>]</span><span><%= news.getDate() %></span></div>
                            <div class="text-xs font-bold text-gray-300 group-hover:text-white transition-colors line-clamp-2 flex justify-between"><%= news.getTitle() %> <i class="fa-solid fa-arrow-up-right-from-square opacity-0 group-hover:opacity-100 text-zzz-accent text-[10px] mt-1"></i></div>
                        </a>
                        <div class="h-[1px] bg-gray-600 w-full opacity-30"></div>
                    <% } } %>
                </div>
                <div class="absolute -bottom-4 -right-4 text-8xl text-black opacity-20 font-black italic select-none pointer-events-none z-0">LOG</div>
            </div>
        </div>

        <% List<Product> upcomingList = (List<Product>) request.getAttribute("listUpcoming");
           if (upcomingList != null && !upcomingList.isEmpty()) { %>
        <div class="mb-12">
            <div class="flex items-center gap-2 mb-6 border-b border-zzz-card pb-2">
                <div class="w-3 h-3 bg-zzz-accent animate-pulse"></div>
                <h2 class="text-xl font-black text-zzz-text uppercase tracking-widest italic">INCOMING SIGNALS <span class="text-zzz-accent text-xs not-italic font-normal ml-2">[ENCRYPTED]</span></h2>
            </div>
            <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                <% for (Product p : upcomingList) { 
                       String glowColor = "from-gray-600"; 
                       if (p.getType().toUpperCase().contains("ICE")) glowColor = "from-cyan-500";
                       else if (p.getType().toUpperCase().contains("FIRE")) glowColor = "from-orange-600";
                       else if (p.getType().toUpperCase().contains("ELECTRIC")) glowColor = "from-blue-600";
                       else if (p.getType().toUpperCase().contains("ETHER")) glowColor = "from-purple-600";
                       else if (p.getType().toUpperCase().contains("PHYSICAL")) glowColor = "from-yellow-600";
                %>
                <a href="character-detail?id=<%= p.getId() %>" class="block relative group h-64 bg-zzz-card border-2 border-dashed border-gray-600 rounded-lg overflow-hidden hover:border-zzz-accent transition-all duration-300 cursor-pointer">
                    <div class="absolute inset-0 bg-gradient-to-b <%= glowColor %> to-zzz-base opacity-10 group-hover:opacity-30 transition-opacity"></div>
                    <div class="absolute top-4 -right-8 w-32 bg-zzz-accent text-zzz-base text-[10px] font-black text-center py-1 rotate-45 z-20 shadow-lg">COMING SOON</div>
                    <div class="absolute inset-0 flex items-end justify-center pb-4 z-10"><img src="images/<%= p.getImage() %>" class="h-[90%] object-contain grayscale contrast-125 group-hover:grayscale-0 group-hover:scale-105 transition-all duration-500" onerror="this.src='https://placehold.co/300x400/111/FFF?text=ENCRYPTED'"></div>
                    <div class="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/diagmonds-light.png')] opacity-20 pointer-events-none z-10"></div>
                    <div class="absolute bottom-0 w-full bg-zzz-base/90 border-t border-gray-700 p-3 z-20">
                        <h3 class="text-lg font-black text-zzz-text uppercase truncate group-hover:text-zzz-accent transition-colors"><%= p.getName() %></h3>
                        <div class="flex justify-between items-center mt-1"><span class="text-[10px] text-gray-400 font-bold uppercase tracking-wider"><%= p.getType() %></span><i class="fa-solid fa-lock text-gray-500 group-hover:text-zzz-accent transition-colors"></i></div>
                    </div>
                </a>
                <% } %>
            </div>
        </div>
        <% } %>

        <div class="flex flex-wrap gap-4 mb-12 justify-center opacity-80 hover:opacity-100 transition-opacity border-b border-zzz-card pb-6">
             <a href="faction?name=victoria" title="Victoria"><i class="fa-solid fa-broom hover:text-zzz-accent cursor-pointer text-lg transition-colors"></i></a>
             <a href="faction?name=hare" title="Cunning Hares"><i class="fa-solid fa-rabbit hover:text-zzz-accent cursor-pointer text-lg transition-colors"></i></a>
             <a href="faction?name=belobog" title="Belobog"><i class="fa-solid fa-hammer hover:text-zzz-accent cursor-pointer text-lg transition-colors"></i></a>
             <a href="faction?name=neps" title="NEPS"><i class="fa-solid fa-shield-halved hover:text-zzz-accent cursor-pointer text-lg transition-colors"></i></a>
             <a href="faction?name=section6" title="Section 6"><i class="fa-solid fa-mask hover:text-zzz-accent cursor-pointer text-lg transition-colors"></i></a>
             <a href="faction?name=calydon" title="Calydon"><i class="fa-solid fa-motorcycle hover:text-zzz-accent cursor-pointer text-lg transition-colors"></i></a>
             <a href="faction?name=obol" title="Obol"><i class="fa-solid fa-person-military-rifle hover:text-zzz-accent cursor-pointer text-lg transition-colors"></i></a>
             <a href="faction?name=silver" title="Silver"><i class="fa-solid fa-shield-virus hover:text-zzz-accent cursor-pointer text-lg transition-colors"></i></a>
             <a href="faction?name=yunkui" title="Yunkui"><i class="fa-solid fa-mountain hover:text-zzz-accent cursor-pointer text-lg transition-colors"></i></a>
             <a href="faction?name=krampus" title="Krampus"><i class="fa-solid fa-skull hover:text-zzz-accent cursor-pointer text-lg transition-colors"></i></a>
             <a href="faction?name=mockingbird" title="Mockingbird"><i class="fa-solid fa-crow hover:text-zzz-accent cursor-pointer text-lg transition-colors"></i></a>
             <a href="faction?name=lyra" title="Lyra"><i class="fa-solid fa-music hover:text-zzz-accent cursor-pointer text-lg transition-colors"></i></a>
             <a href="faction?name=spook" title="Spook"><i class="fa-solid fa-ghost hover:text-zzz-accent cursor-pointer text-lg transition-colors"></i></a>
        </div>

        <div id="agents-section" class="mb-12 scroll-mt-24">
            <div class="flex items-center justify-between mb-6">
                <div class="flex items-center gap-2"><div class="w-2 h-8 bg-zzz-accent"></div><h2 class="text-3xl font-black text-zzz-text uppercase italic tracking-tighter">AGENTS</h2></div>
                <div class="h-[1px] flex-1 bg-gray-700 ml-4"></div>
            </div>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                <% List<Product> listAgents = (List<Product>) request.getAttribute("listAgents");
                   if (listAgents != null && !listAgents.isEmpty()) {
                       for (Product p : listAgents) {
                           boolean isSRank = p.getRarity() != null && p.getRarity().contains("S");
                           String typeStr = (p.getType() != null) ? p.getType().toUpperCase() : "";
                           String glowColor = "from-gray-600"; String elementIcon = "fa-circle";
                           if (typeStr.contains("ICE")) { glowColor = "from-cyan-500"; elementIcon = "fa-snowflake"; }
                           else if (typeStr.contains("FIRE")) { glowColor = "from-orange-600"; elementIcon = "fa-fire"; }
                           else if (typeStr.contains("ELECTRIC")) { glowColor = "from-blue-600"; elementIcon = "fa-bolt"; }
                           else if (typeStr.contains("ETHER")) { glowColor = "from-purple-600"; elementIcon = "fa-atom"; }
                           else if (typeStr.contains("PHYSICAL")) { glowColor = "from-yellow-600"; elementIcon = "fa-fist-raised"; }

                           String factionLogo = "default.png"; String n = p.getName().toUpperCase(); String d = p.getDescription().toUpperCase();
                           String factionName = "UNKNOWN";
                           if (d.contains("VICTORIA")||n.contains("ELLEN")||n.contains("LYCAON")||n.contains("RINA")||n.contains("CORIN")) { factionLogo="victoria.png"; factionName="VICTORIA"; }
                           else if (d.contains("CUNNING")||n.contains("ANBY")||n.contains("NICOLE")||n.contains("BILLY")||n.contains("NEKOMATA")) { factionLogo="hare.png"; factionName="HARES"; }
                           else if (d.contains("BELOBOG")||n.contains("KOLEDA")||n.contains("BEN")||n.contains("GRACE")||n.contains("ANTON")) { factionLogo="belobog.png"; factionName="BELOBOG"; }
                           else if (d.contains("NEPS")||n.contains("ZHU YUAN")||n.contains("QINGYI")||n.contains("JANE")||n.contains("SETH")) { factionLogo="neps.png"; factionName="N.E.P.S"; }
                           else if (d.contains("SECTION 6")||n.contains("MIYABI")||n.contains("YANAGI")||n.contains("HARUMASA")||n.contains("SOUKAKU")) { factionLogo="section6.png"; factionName="SECTION 6"; }
                           else if (d.contains("CALYDON")||n.contains("CAESAR")||n.contains("BURNICE")||n.contains("LUCY")||n.contains("PIPER")||n.contains("LIGHTER")) { factionLogo="calydon.png"; factionName="CALYDON"; }
                           else if (d.contains("OBOL")||n.contains("SOLDIER")) { factionLogo="obol.png"; factionName="OBOL"; }
                           else if (d.contains("SILVER")) { factionLogo="silver.png"; factionName="SILVER"; }
                %>
                <div class="bg-zzz-card border border-gray-700 hover:border-zzz-accent transition-all duration-300 group rounded-xl overflow-hidden relative flex flex-col shadow-lg hover:shadow-[0_0_20px_rgba(249,109,0,0.3)] hover:-translate-y-1">
                    <a href="character-detail?id=<%= p.getId() %>" class="block h-80 relative overflow-hidden flex items-center justify-center bg-[#2a2f38] cursor-pointer">
                        <div class="absolute inset-0 opacity-20 group-hover:opacity-60 transition-opacity duration-500 bg-gradient-to-t <%= glowColor %> to-transparent"></div>
                        <div class="absolute inset-0 flex items-center justify-center z-0"><img src="images/factions/<%= factionLogo %>" class="w-[85%] h-[85%] object-contain opacity-25 group-hover:opacity-40 transition-opacity duration-500 faction-watermark" onerror="this.style.display='none'"></div>
                        <div class="relative z-10 w-full h-full flex items-end justify-center pb-4"><img src="images/<%= p.getImage() %>" class="max-h-[95%] max-w-[95%] object-contain drop-shadow-2xl transform group-hover:scale-105 transition-transform duration-500" onerror="this.src='https://placehold.co/300x400/333/FFF?text=NO+SIGNAL'"></div>
                        <div class="absolute top-3 left-3 z-20"><span class="bg-zzz-base/90 backdrop-blur border <%= isSRank?"border-zzz-pink text-zzz-pink":"border-zzz-blue text-zzz-blue" %> px-2 py-1 rounded text-xs font-black italic shadow-lg"><i class="fa-solid <%= isSRank?"fa-star":"fa-star-half-stroke" %>"></i> <%= p.getRarity() %></span></div>
                    </a>
                    <div class="p-5 flex-1 flex flex-col bg-zzz-base border-t border-gray-700 relative z-20">
                        <div class="flex justify-between items-center mb-3">
                            <a href="character-detail?id=<%= p.getId() %>" class="text-2xl font-black text-zzz-text uppercase italic tracking-tighter leading-none truncate pr-2 group-hover:text-zzz-accent transition-colors cursor-pointer"><%= p.getName() %></a>
                            <div class="w-8 h-8 rounded-full bg-zzz-card flex items-center justify-center border border-gray-600 group-hover:border-zzz-text transition-colors flex-shrink-0" title="<%= p.getType() %>"><i class="fa-solid <%= elementIcon %> text-gray-400 group-hover:text-zzz-text transition-colors text-sm"></i></div>
                        </div>
                        <div class="mt-auto flex items-center justify-between pt-4 border-t border-gray-700 border-dashed">
                            <div class="text-zzz-accent font-bold text-lg font-mono flex flex-col leading-none"><span><%= String.format("%,.0f", p.getPrice()) %></span><span class="text-[9px] text-gray-500">POLYCHROME</span></div>
                            <form action="cart" method="POST">
                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                <input type="hidden" name="num" value="1">
                                <button type="submit" class="bg-zzz-text hover:bg-zzz-accent hover:text-white text-zzz-base px-5 py-2 rounded-sm font-black uppercase text-xs tracking-wide transition-all flex items-center gap-2 hover:shadow-[2px_2px_0_rgba(255,255,255,0.2)] active:translate-y-1 active:shadow-none">TUNE <i class="fa-solid fa-signal"></i></button>
                            </form>
                        </div>
                    </div>
                </div>
                <% } } %>
            </div>
            <div class="flex justify-center mt-12 pb-8 border-b border-zzz-card">
                <a href="agents" class="group relative inline-flex items-center justify-center px-10 py-4 font-black uppercase tracking-[0.2em] text-zzz-base transition-all duration-200 bg-zzz-accent font-mono hover:bg-white transform -skew-x-12">
                    <span class="skew-x-12 flex items-center gap-3"><i class="fa-solid fa-layer-group text-xl"></i><span>VIEW ALL FACTIONS</span><i class="fa-solid fa-arrow-right-long group-hover:translate-x-2 transition-transform"></i></span>
                </a>
            </div>
        </div>

        <div id="wengines-section" class="mb-12 scroll-mt-24">
            <div class="flex items-center justify-between mb-6">
                <div class="flex items-center gap-2"><div class="w-2 h-8 bg-blue-500"></div><h2 class="text-3xl font-black text-zzz-text uppercase italic tracking-tighter">W-ENGINES</h2></div>
                <div class="h-[1px] flex-1 bg-gray-700 ml-4"></div>
            </div>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                <% List<Product> listW = (List<Product>) request.getAttribute("listWEngines");
                   if (listW != null && !listW.isEmpty()) {
                       for (Product p : listW) {
                           boolean isSRank = p.getRarity() != null && p.getRarity().contains("S");
                %>
                <div class="bg-zzz-card/50 border border-gray-700 hover:border-blue-400 transition-all duration-300 group rounded-sm overflow-hidden relative flex flex-col shadow-lg">
                    <div class="h-64 relative overflow-hidden flex items-center justify-center bg-[#151515]">
                        <div class="absolute inset-0 opacity-10 bg-[url('https://www.transparenttextures.com/patterns/carbon-fibre.png')]"></div>
                        <div class="relative z-10 w-full h-full flex items-center justify-center p-6"><img src="images/<%= p.getImage() %>" class="max-h-full max-w-full object-contain drop-shadow-2xl transform group-hover:scale-110 transition-transform duration-500" onerror="this.src='https://placehold.co/300x300/333/FFF?text=W-ENGINE'"></div>
                        <div class="absolute top-2 right-2 z-20"><span class="bg-black/90 border <%= isSRank?"border-zzz-pink text-zzz-pink":"border-zzz-blue text-zzz-blue" %> px-2 py-0.5 rounded text-[10px] font-black uppercase"><%= p.getRarity() %></span></div>
                    </div>
                    <div class="p-4 flex-1 flex flex-col bg-zzz-base border-t-2 border-blue-900/50 relative z-20">
                        <h3 class="text-xl font-black text-zzz-text uppercase italic tracking-tight mb-2 truncate group-hover:text-blue-400 transition-colors"><%= p.getName() %></h3>
                        <div class="mt-auto flex items-center justify-between">
                            <div class="text-blue-400 font-bold text-lg font-mono"><%= String.format("%,.0f", p.getPrice()) %></div>
                            <form action="cart" method="POST">
                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                <input type="hidden" name="num" value="1">
                                <button type="submit" class="bg-transparent border border-blue-500 text-blue-500 hover:bg-blue-500 hover:text-white px-4 py-1 text-xs font-bold uppercase transition-all">GET</button>
                            </form>
                        </div>
                    </div>
                </div>
                <% } } %>
            </div>
        </div>

    </main>
    <footer class="bg-zzz-base border-t border-zzz-card py-8 mt-12 text-center"><p class="text-gray-500 text-xs font-mono">© 2024 RANDOM PLAY. NEW ERIDU.</p></footer>

    <script>
        function searchLive(input) {
            const resultBox = document.getElementById("search-results");
            const txt = input.value;
            if (txt.trim() === "") { resultBox.innerHTML = ""; resultBox.classList.add("hidden"); return; }
            fetch("search-ajax?txt=" + txt).then(r => r.text()).then(d => {
                if (d.trim() !== "") { resultBox.innerHTML = d; resultBox.classList.remove("hidden"); } else { resultBox.classList.add("hidden"); }
            });
        }
        document.addEventListener("click", function(event) {
            const searchBox = document.querySelector(".relative.group");
            const resultBox = document.getElementById("search-results");
            if (!searchBox.contains(event.target)) { resultBox.classList.add("hidden"); }
        });
    </script>
</body>
</html>