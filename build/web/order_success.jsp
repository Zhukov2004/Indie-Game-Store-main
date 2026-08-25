<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Success - Proxy Network</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: { colors: { zzz: { base: '#222831', card: '#393E46', accent: '#F96D00', success: '#00e054' } } }
            }
        }
    </script>
    <style>
        .crt-overlay { background: linear-gradient(rgba(34, 40, 49, 0) 50%, rgba(0, 0, 0, 0.1) 50%); background-size: 100% 4px; pointer-events: none; position: fixed; inset: 0; z-index: 50; }
        .bg-grid { background-image: radial-gradient(#393E46 1px, transparent 1px); background-size: 20px 20px; }
    </style>
</head>
<body class="bg-zzz-base text-white font-mono h-screen flex flex-col items-center justify-center bg-grid relative overflow-hidden">

    <div class="crt-overlay"></div>

    <div class="absolute top-0 left-0 w-full h-2 bg-zzz-success shadow-[0_0_20px_#00e054]"></div>
    <div class="absolute bottom-0 left-0 w-full h-2 bg-zzz-success shadow-[0_0_20px_#00e054]"></div>

    <div class="relative z-10 bg-zzz-card border-2 border-zzz-success p-10 max-w-lg w-full text-center transform -skew-x-3 shadow-[0_0_50px_rgba(0,224,84,0.2)]">
        
        <div class="w-24 h-24 bg-zzz-base rounded-full flex items-center justify-center mx-auto mb-6 border-4 border-zzz-success shadow-[0_0_20px_#00e054]">
            <i class="fa-solid fa-check text-5xl text-zzz-success"></i>
        </div>

        <h1 class="text-4xl font-black uppercase text-zzz-success mb-2 tracking-tighter">COMMISSION COMPLETE</h1>
        <p class="text-gray-400 text-sm mb-8">Supply request has been processed successfully.</p>

        <div class="bg-zzz-base p-4 border border-gray-600 mb-8 text-left">
            <div class="flex justify-between mb-2">
                <span class="text-gray-500 text-xs">STATUS</span>
                <span class="text-zzz-success font-bold text-xs">APPROVED</span>
            </div>
            <div class="flex justify-between">
                <span class="text-gray-500 text-xs">ESTIMATED ARRIVAL</span>
                <span class="text-white font-bold text-xs">IMMEDIATE (HOLLOW CHANNEL)</span>
            </div>
        </div>

        <div class="flex gap-4">
            <a href="home" class="flex-1 bg-zzz-success text-black py-3 font-black uppercase tracking-wider hover:bg-white transition-colors">
                BACK TO HOME
            </a>
            <a href="agents" class="flex-1 bg-transparent border-2 border-zzz-success text-zzz-success py-3 font-black uppercase tracking-wider hover:bg-zzz-success hover:text-black transition-colors">
                VIEW AGENTS
            </a>
        </div>

    </div>

</body>
</html>