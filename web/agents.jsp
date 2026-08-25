<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Select Faction - ZZZ Archive</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        zzz: {
                            base: '#222831',    // Navy
                            card: '#393E46',    // Grey
                            accent: '#F96D00',  // Orange
                            text: '#F2F2F2'     // White
                        }
                    },
                    fontFamily: { mono: ['Courier New', 'monospace'] }
                }
            }
        }
    </script>
    
    <style>
        .crt-overlay {
            background: linear-gradient(rgba(34, 40, 49, 0) 50%, rgba(0, 0, 0, 0.1) 50%);
            background-size: 100% 4px; pointer-events: none; position: fixed; inset: 0; z-index: 50;
        }
        .bg-grid-pattern {
            background-image: linear-gradient(#393E46 1px, transparent 1px), linear-gradient(90deg, #393E46 1px, transparent 1px);
            background-size: 40px 40px;
        }
        .faction-card:hover {
            box-shadow: 0 0 20px rgba(249, 109, 0, 0.3);
            transform: scale(1.02);
            border-color: #F96D00;
        }
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
    </style>
</head>
<body class="bg-zzz-base text-zzz-text font-mono h-screen flex flex-col overflow-hidden relative bg-grid-pattern">

    <div class="crt-overlay"></div>

    <nav class="sticky top-0 z-40 bg-zzz-base/95 backdrop-blur-md border-b border-zzz-card">
        <div class="max-w-7xl mx-auto px-4">
            <div class="flex items-center justify-between h-20">
                <div class="flex items-center gap-3">
                    <a href="home" class="flex items-center gap-2 group">
                        <img src="images/logo.png" class="h-10 object-contain" onerror="this.style.display='none'">
                        <span class="text-2xl font-black italic tracking-tighter text-zzz-text group-hover:text-zzz-accent transition-colors">/// RANDOM PLAY</span>
                    </a>
                </div>
                
                <div class="flex items-baseline space-x-8 text-sm font-bold tracking-widest">
                    <a href="home" class="text-gray-400 hover:text-zzz-text transition-colors">HOME</a>
                    <a href="agents" class="text-zzz-accent border-b-2 border-zzz-accent pb-1">AGENTS</a>
                    <a href="#" class="text-gray-400 hover:text-zzz-text transition-colors">W-ENGINES</a>
                </div>
            </div>
        </div>
    </nav>

    <main class="flex-1 overflow-y-auto p-4 md:p-8 flex items-center justify-center relative z-10 no-scrollbar">
        
        <a href="home" class="hidden md:flex fixed right-0 top-1/2 transform -translate-y-1/2 bg-zzz-card border-l-4 border-zzz-accent p-4 text-zzz-accent hover:bg-gray-700 transition-all writing-vertical-rl font-bold tracking-widest z-50 items-center gap-2 cursor-pointer shadow-lg">
            <i class="fa-solid fa-reply mb-2"></i> QUAY LẠI
        </a>

        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 max-w-6xl w-full pb-10">
            <% 
                String[][] factions = {
                    {"krampus.png", "Quy Chuẩn Krampus", "krampus"},
                    {"spook.png", "Ngôi Nhà Quái Dị", "spook"},
                    {"yunkui.png", "Vân Khuy Sơn", "yunkui"},
                    {"Mockingbird.png", "Chim Nhại", "mockingbird"},
                    {"silver.png", "Lực Lượng Phòng Vệ", "silver"}, 
                    {"lyra.png", "Chòm Sao Thiên Cầm", "lyra"},
                    {"section6.png", "Biệt Đội Ứng Phó Lỗ Hổng 6", "section6"},
                    {"calydon.png", "Những Đứa Con Của Calydon", "calydon"},
                    {"neps.png", "Đội Điều Tra Hình Sự", "neps"},
                    {"obol.png", "Đội OBOL", "obol"},
                    {"victoria.png", "Nhà Victoria", "victoria"},
                    {"belobog.png", "Công Nghiệp Nặng Belobog", "belobog"},
                    {"hare.png", "Cunning Hares", "hare"}
                };

                for(String[] f : factions) {
            %>
            
            <a href="faction?name=<%= f[2] %>" class="faction-card group relative bg-zzz-card border-2 border-gray-600 rounded-lg h-40 flex flex-col items-center justify-center transition-all duration-300 cursor-pointer overflow-hidden">
                <div class="flex-1 flex items-center justify-center w-full p-4 relative">
                    <div class="absolute inset-0 bg-zzz-accent opacity-0 group-hover:opacity-10 blur-xl transition-opacity duration-300"></div>
                    <img src="images/factions/<%= f[0] %>" alt="<%= f[1] %>" class="h-20 w-20 object-contain filter drop-shadow-lg group-hover:scale-110 transition-transform duration-300" onerror="this.src='https://placehold.co/100x100/393E46/FFF?text=LOGO'">
                </div>
                <div class="w-full bg-[#2a2f35] py-2 text-center border-t border-gray-600 group-hover:bg-zzz-accent group-hover:text-white transition-colors z-10">
                    <span class="text-[10px] md:text-xs font-bold uppercase tracking-wider block px-1 truncate"><%= f[1] %></span>
                </div>
            </a>

            <% } %>
        </div>
    </main>
</body>
</html>