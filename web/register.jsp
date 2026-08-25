<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Register - Proxy Network</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { background-color: #0a0a0a; color: white; font-family: monospace; }
        .crt { background: linear-gradient(rgba(18, 16, 16, 0) 50%, rgba(0, 0, 0, 0.1) 50%); background-size: 100% 4px; pointer-events: none; position: fixed; inset: 0; z-index: 10; }
    </style>
</head>
<body class="flex items-center justify-center h-screen bg-black relative">
    <div class="crt"></div>

    <div class="relative z-20 bg-[#111] border-2 border-[#00ccff] p-10 w-96 shadow-[0_0_20px_#00ccff]">
        <h2 class="text-3xl font-black text-[#00ccff] text-center mb-6 uppercase">/// NEW SIGNAL ///</h2>
        
        <% if(request.getAttribute("error") != null) { %>
            <div class="text-red-500 text-xs mb-4 font-bold border border-red-500 p-2">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="register" method="post" class="flex flex-col gap-4">
            <div>
                <label class="text-xs text-gray-400 font-bold">FULL NAME</label>
                <input type="text" name="fullname" required class="w-full bg-[#222] border border-gray-600 text-white p-2 focus:border-[#00ccff] outline-none">
            </div>
            <div>
                <label class="text-xs text-gray-400 font-bold">USERNAME</label>
                <input type="text" name="user" required class="w-full bg-[#222] border border-gray-600 text-white p-2 focus:border-[#00ccff] outline-none">
            </div>
            <div>
                <label class="text-xs text-gray-400 font-bold">PASSWORD</label>
                <input type="password" name="pass" required class="w-full bg-[#222] border border-gray-600 text-white p-2 focus:border-[#00ccff] outline-none">
            </div>
            <div>
                <label class="text-xs text-gray-400 font-bold">CONFIRM PASSWORD</label>
                <input type="password" name="repass" required class="w-full bg-[#222] border border-gray-600 text-white p-2 focus:border-[#00ccff] outline-none">
            </div>
            <button type="submit" class="bg-[#00ccff] text-black font-black py-3 hover:bg-white transition-colors uppercase tracking-widest mt-4">
                REGISTER
            </button>
        </form>
        
        <div class="mt-6 text-center text-xs text-gray-500">
            Already a Proxy? <a href="login" class="text-[#00ccff] hover:underline">Login</a>
        </div>
    </div>
</body>
</html>