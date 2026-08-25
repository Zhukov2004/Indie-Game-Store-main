<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Login - Proxy Network</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #0a0a0a; color: white; font-family: monospace; }
        .crt { background: linear-gradient(rgba(18, 16, 16, 0) 50%, rgba(0, 0, 0, 0.1) 50%); background-size: 100% 4px; pointer-events: none; position: fixed; inset: 0; z-index: 10; }
    </style>
</head>
<body class="flex items-center justify-center h-screen bg-[url('https://wallpaperaccess.com/full/12245304.jpg')] bg-cover bg-center relative">
    <div class="crt"></div>
    <div class="absolute inset-0 bg-black/80"></div> <div class="relative z-20 bg-[#111] border-2 border-[#FACC15] p-10 w-96 shadow-[0_0_20px_#FACC15] transform -skew-x-3">
        <h2 class="text-3xl font-black text-[#FACC15] text-center mb-6 uppercase">/// ACCESS HDD ///</h2>
        
        <% if(request.getAttribute("error") != null) { %>
            <div class="text-red-500 text-xs mb-4 font-bold border border-red-500 p-2 bg-red-500/10">
                ERROR: <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="login" method="post" class="flex flex-col gap-4">
            <div>
                <label class="text-xs text-gray-400 font-bold">PROXY ID (USERNAME)</label>
                <input type="text" name="user" required class="w-full bg-[#222] border border-gray-600 text-white p-2 mt-1 focus:outline-none focus:border-[#FACC15]">
            </div>
            <div>
                <label class="text-xs text-gray-400 font-bold">KEY (PASSWORD)</label>
                <input type="password" name="pass" required class="w-full bg-[#222] border border-gray-600 text-white p-2 mt-1 focus:outline-none focus:border-[#FACC15]">
            </div>
            <button type="submit" class="bg-[#FACC15] text-black font-black py-3 hover:bg-white transition-colors uppercase tracking-widest mt-4">
                CONNECT
            </button>
        </form>
        
        <div class="mt-6 text-center text-xs text-gray-500">
            New Proxy? <a href="register" class="text-[#FACC15] hover:underline">Register Signal</a>
        </div>
        <div class="mt-2 text-center text-xs text-gray-500">
            <a href="home" class="hover:text-white"><< BACK TO SHOP</a>
        </div>
    </div>
</body>
</html>