<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Faction Details - ZZZ Archive</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        zzz: { base: '#222831', card: '#393E46', accent: '#F96D00', text: '#F2F2F2' }
                    },
                    fontFamily: { mono: ['Courier New', 'monospace'] }
                }
            }
        }
    </script>
    <style>
        .skewed-bg-left { transform: skewX(-15deg); transform-origin: bottom left; }
        .scrollbar-hide::-webkit-scrollbar { display: none; }
        .active-thumbnail { border-color: #F96D00 !important; filter: grayscale(0%) !important; transform: scale(1.05); }
        .video-wrapper { position: absolute; top: 0; left: 0; width: 100%; height: 100%; overflow: hidden; z-index: 0; pointer-events: none; }
        .video-iframe { width: 100vw; height: 56.25vw; min-height: 100vh; min-width: 177.77vh; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); opacity: 0.6; }
    </style>
</head>

<%
    List<Product> members = (List<Product>) request.getAttribute("factionMembers");
    Product firstMember = new Product(); firstMember.setName("UNKNOWN"); firstMember.setImage("no-image.png"); firstMember.setVideoId("f7lQWp1f0kQ");
    if (members != null && !members.isEmpty()) { firstMember = members.get(0); if(firstMember.getVideoId() == null) firstMember.setVideoId("f7lQWp1f0kQ"); }
    String currentCode = (String) request.getAttribute("currentFactionStr"); if(currentCode == null) currentCode = "";
%>

<body class="bg-zzz-base font-sans overflow-hidden h-screen flex text-zzz-text">

    <div class="flex-1 relative flex bg-zzz-base overflow-hidden">
        <div class="video-wrapper">
            <iframe id="bg-video" class="video-iframe" src="https://www.youtube.com/embed/<%= firstMember.getVideoId() %>?autoplay=1&mute=1&controls=0&loop=1&playlist=<%= firstMember.getVideoId() %>&showinfo=0&rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
            <div class="absolute inset-0 bg-gradient-to-r from-zzz-base via-zzz-base/80 to-transparent z-10"></div>
        </div>

        <div class="absolute top-0 left-0 h-40 w-72 bg-zzz-accent z-30 skewed-bg-left -translate-x-14 shadow-xl flex items-center pl-20 pt-4">
            <div class="transform skew-x-[15deg] text-white">
                <h3 class="text-xs font-bold uppercase tracking-widest opacity-80 mb-1">DATABASE //</h3>
                <h1 class="text-4xl font-black uppercase leading-none">AGENTS</h1>
            </div>
        </div>

        <div class="w-1/2 h-full relative z-20 pointer-events-none">
            <div class="h-full w-full flex items-end justify-center relative z-10 pb-8 pr-10">
                 <img id="main-char-image" src="images/<%= firstMember.getImage() %>" class="h-[90%] max-w-full object-contain drop-shadow-[0_10px_30px_rgba(0,0,0,0.8)] transition-all duration-500" onerror="this.src='https://placehold.co/600x900/393E46/FFF?text=NO+IMAGE'">
            </div>
        </div>

        <div class="w-1/2 h-full flex flex-col justify-center pl-16 pr-10 relative z-20 pt-16">
            <h1 id="main-char-name" class="text-7xl font-black text-zzz-text uppercase tracking-tighter mb-6 leading-none drop-shadow-lg"><%= firstMember.getName() %></h1>
            <div class="flex items-center gap-4 mb-8">
                <div class="bg-zzz-card/80 backdrop-blur border border-gray-500 rounded-full h-10 flex items-center px-1">
                    <div class="bg-zzz-text text-zzz-base rounded-full w-8 h-8 flex items-center justify-center mr-2 text-xs font-bold">CV</div>
                    <span class="font-bold text-zzz-text pr-4 text-sm">Unknown</span>
                </div>
            </div>
            <div class="mb-8">
                <p class="text-lg font-bold text-zzz-text italic pl-6 border-l-4 border-zzz-accent drop-shadow-md">"Dữ liệu trích xuất từ HDD System. Sẵn sàng nhận lệnh."</p>
            </div>
            <div class="text-gray-300 font-medium text-sm leading-relaxed mb-10 max-w-md h-24 overflow-hidden drop-shadow-md">
                <p id="main-char-desc"><%= firstMember.getDescription() %></p>
            </div>

            <div class="absolute bottom-36 right-0 z-30 pr-4">
                <a id="btn-detail" href="character-detail?id=<%= firstMember.getId() %>" class="group flex items-center gap-3 bg-zzz-accent text-white px-6 py-3 font-black uppercase tracking-widest hover:bg-white hover:text-zzz-accent transition-all shadow-[0_0_15px_rgba(249,109,0,0.6)] cursor-pointer transform -skew-x-12 rounded-sm">
                    <div class="skew-x-12 flex items-center gap-2"><span>DỮ LIỆU CHIẾN ĐẤU</span><i class="fa-solid fa-arrow-right group-hover:translate-x-1 transition-transform"></i></div>
                </a>
            </div>

            <div class="mt-auto mb-8 w-full">
                <div class="flex gap-3 overflow-x-auto scrollbar-hide py-2 pr-4 items-center">
                    <% if (members != null) { for (int i = 0; i < members.size(); i++) { Product p = members.get(i); 
                        String jsName = p.getName().replace("'", "\\'"); String jsDesc = (p.getDescription() != null) ? p.getDescription().replace("'", "\\'").replace("\n", " ") : ""; String jsImg = p.getImage(); String jsVideo = (p.getVideoId() != null) ? p.getVideoId() : "f7lQWp1f0kQ"; int jsId = p.getId(); %>
                    <div class="thumbnail-item flex-shrink-0 w-32 h-14 bg-zzz-card rounded-md overflow-hidden border-2 border-transparent relative cursor-pointer transition-all grayscale hover:grayscale-0 hover:border-zzz-accent group <%= (i == 0) ? "active-thumbnail" : "" %>"
                         onclick="selectCharacter(this, '<%= jsImg %>', '<%= jsName %>', '<%= jsDesc %>', '<%= jsVideo %>', <%= jsId %>)">
                        <img src="images/<%= jsImg %>" class="w-full h-full object-cover opacity-70 group-hover:opacity-100">
                        <div class="absolute bottom-0 w-full bg-zzz-base/80 text-white text-[9px] font-bold px-2 py-0.5 uppercase truncate"><%= p.getName() %></div>
                    </div>
                    <% } } %>
                </div>
            </div>
        </div>
    </div>

    <div class="w-24 bg-zzz-card h-full flex flex-col items-center py-4 border-l border-gray-600 z-50 shadow-2xl relative flex-shrink-0">
        <a href="home" class="w-14 h-14 mb-4 bg-zzz-accent rounded-xl flex items-center justify-center text-white text-xl hover:scale-110 transition-transform shadow-lg cursor-pointer flex-shrink-0"><i class="fa-solid fa-house"></i></a>
        <div class="w-10 h-[1px] bg-gray-600 mb-4 flex-shrink-0"></div>
        <div class="flex-1 w-full overflow-y-auto scrollbar-hide flex flex-col items-center gap-4 px-2 pb-20">
            <% String[][] allFactions = {{"victoria", "victoria.png", "Victoria"}, {"hare", "hare.png", "Cunning Hares"}, {"belobog", "belobog.png", "Belobog"}, {"neps", "neps.png", "N.E.P.S"}, {"section6", "section6.png", "Section 6"}, {"calydon", "calydon.png", "Calydon"}, {"obol", "obol.png", "Obol"}, {"silver", "silver.png", "Silver"}, {"yunkui", "yunkui.png", "Yunkui"}, {"krampus", "krampus.png", "Krampus"}, {"mockingbird", "mockingbird.png", "Mockingbird"}, {"lyra", "lyra.png", "Lyra"}, {"spook", "spook.png", "Spook"}};
               for(String[] f : allFactions) { boolean isActive = f[0].equalsIgnoreCase(currentCode); %>
            <a href="faction?name=<%= f[0] %>" title="<%= f[2] %>" class="w-16 h-16 rounded-xl flex items-center justify-center transition-all cursor-pointer relative group flex-shrink-0 <%= isActive ? "bg-zzz-base border-2 border-zzz-accent" : "bg-zzz-base border border-transparent hover:border-gray-500" %>">
                <img src="images/factions/<%= f[1] %>" class="w-10 h-10 object-contain" onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                <i class="fa-solid fa-shield-cat text-2xl text-gray-600 hidden"></i>
                <% if(isActive) { %> <div class="absolute -right-3 top-1/2 -translate-y-1/2 w-1.5 h-8 bg-zzz-accent rounded-l-full"></div> <% } %>
            </a>
            <% } %>
        </div>
    </div>

    <script>
        function selectCharacter(element, imageName, charName, charDesc, videoId, charId) {
            const mainImage = document.getElementById('main-char-image');
            mainImage.style.opacity = '0'; mainImage.style.transform = 'translateX(30px)'; 
            setTimeout(() => { mainImage.src = 'images/' + imageName; mainImage.style.opacity = '1'; mainImage.style.transform = 'translateX(0)'; }, 300);
            document.getElementById('main-char-name').innerText = charName;
            document.getElementById('main-char-desc').innerText = charDesc;
            document.getElementById('bg-video').src = "https://www.youtube.com/embed/" + videoId + "?autoplay=1&mute=1&controls=0&loop=1&playlist=" + videoId + "&showinfo=0&rel=0";
            document.getElementById('btn-detail').href = "character-detail?id=" + charId;
            document.querySelectorAll('.thumbnail-item').forEach(thumb => thumb.classList.remove('active-thumbnail'));
            element.classList.add('active-thumbnail');
        }
    </script>
</body>
</html>