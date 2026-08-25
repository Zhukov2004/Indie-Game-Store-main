<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Payment Gateway - ZZZ</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        tailwind.config = { theme: { extend: { colors: { zzz: { base: '#222831', card: '#393E46', accent: '#F96D00', text: '#F2F2F2' } } } } }
    </script>
</head>
<body class="bg-zzz-base text-zzz-text font-mono h-screen flex flex-col items-center justify-center">

    <div class="bg-zzz-card border-2 border-zzz-accent p-8 max-w-md w-full shadow-[0_0_30px_#F96D00] text-center relative overflow-hidden">
        
        <div class="absolute top-0 left-0 w-full h-1 bg-zzz-accent"></div>
        <div class="absolute -right-10 -bottom-10 text-9xl text-black opacity-20 font-black italic">PAY</div>

        <h1 class="text-2xl font-black uppercase text-zzz-accent mb-2">SCAN TO PAY</h1>
        <p class="text-sm text-gray-400 mb-6">Inter-Knot Banking System</p>

<div class="bg-white p-2 inline-block rounded mb-6 border-4 border-zzz-accent shadow-lg">
    <img src="images/qr_payment.jpg" 
         alt="Scan to Pay" 
         class="w-48 h-48 object-contain">
</div>

        <div class="text-left bg-zzz-base p-4 rounded border border-gray-600 mb-6">
            <div class="flex justify-between mb-2">
                <span class="text-gray-500 text-xs">AMOUNT:</span>
                <span class="text-zzz-accent font-bold text-xl"><%= String.format("%,.0f", request.getAttribute("amount")) %> POLY</span>
            </div>
            <div class="flex justify-between">
                <span class="text-gray-500 text-xs">STATUS:</span>
                <span class="text-yellow-400 font-bold text-xs bg-yellow-900/30 px-2 py-0.5 rounded border border-yellow-500">PENDING APPROVAL</span>
            </div>
        </div>

        <p class="text-xs text-gray-500 mb-6">
            Please complete the transfer. Admin Fairy will verify your transaction shortly.
        </p>

        <a href="home" class="block w-full bg-zzz-accent text-white py-3 font-black uppercase tracking-widest hover:bg-white hover:text-black transition-colors">
            RETURN TO BASE
        </a>
    </div>

</body>
</html>