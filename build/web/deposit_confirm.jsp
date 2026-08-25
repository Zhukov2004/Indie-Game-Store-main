<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Confirm Transaction - ZZZ</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: { colors: { zzz: { base: '#222831', card: '#393E46', accent: '#F96D00', text: '#F2F2F2' } } }
            }
        }
    </script>
    <style>
        .bg-grid { background-image: radial-gradient(#393E46 1px, transparent 1px); background-size: 20px 20px; }
    </style>
</head>
<body class="bg-zzz-base text-zzz-text font-mono h-screen flex flex-col items-center justify-center bg-grid">

    <%
        String amountRaw = request.getAttribute("amount").toString();
        double amount = Double.parseDouble(amountRaw);
        // Giả lập tính tiền thật (Ví dụ 60 Poly = $0.99)
        double realMoney = (amount / 60.0) * 0.99; 
    %>

    <div class="relative z-10 bg-zzz-card border-2 border-zzz-accent p-10 max-w-lg w-full shadow-2xl relative overflow-hidden">
        
        <div class="text-center mb-8 border-b border-gray-600 pb-4">
            <i class="fa-solid fa-shield-halved text-4xl text-zzz-accent mb-2 animate-pulse"></i>
            <h1 class="text-2xl font-black uppercase tracking-tighter text-white">VERIFY TRANSACTION</h1>
            <p class="text-xs text-gray-400 mt-1">Inter-Knot Secure Payment Gateway</p>
        </div>

        <div class="space-y-4 mb-8">
            <div class="flex justify-between items-center bg-zzz-base p-4 border border-gray-600">
                <span class="text-gray-400 text-sm font-bold">ITEM</span>
                <span class="text-white font-bold flex items-center gap-2">
                    <i class="fa-solid fa-layer-group text-zzz-accent"></i> POLYCHROME BUNDLE
                </span>
            </div>
            
            <div class="flex justify-between items-center bg-zzz-base p-4 border border-gray-600">
                <span class="text-gray-400 text-sm font-bold">QUANTITY</span>
                <span class="text-zzz-accent font-black text-xl"><%= String.format("%,.0f", amount) %></span>
            </div>

            <div class="flex justify-between items-center bg-zzz-base p-4 border border-gray-600">
                <span class="text-gray-400 text-sm font-bold">ESTIMATED COST</span>
                <span class="text-white font-bold text-lg">$<%= String.format("%.2f", realMoney) %></span>
            </div>
        </div>

        <div class="bg-yellow-900/30 border-l-4 border-yellow-500 p-4 mb-8">
            <p class="text-[10px] text-yellow-200 uppercase font-bold leading-relaxed">
                <i class="fa-solid fa-triangle-exclamation mr-1"></i> Warning:
                Please ensure your Inter-Knot account ID is correct. Transactions cannot be reversed once the signal is transmitted.
            </p>
        </div>

        <div class="flex gap-4">
            <a href="deposit" class="flex-1 py-4 text-center border border-gray-500 text-gray-400 font-bold uppercase hover:bg-gray-700 hover:text-white transition-all">
                CANCEL
            </a>

            <form action="deposit" method="POST" class="flex-1">
                <input type="hidden" name="amount" value="<%= amountRaw %>">
                <button type="submit" class="w-full h-full bg-zzz-accent text-white font-black uppercase tracking-widest hover:bg-white hover:text-black transition-all shadow-[0_0_15px_#F96D00]">
                    CONFIRM <i class="fa-solid fa-check ml-2"></i>
                </button>
            </form>
        </div>

        <div class="absolute -top-6 -right-6 text-8xl text-black opacity-20 font-black italic select-none pointer-events-none">PAY</div>
    </div>

</body>
</html>