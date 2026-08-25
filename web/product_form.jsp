<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Manage Signal - Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: { extend: { colors: { zzz: { base: '#222831', card: '#393E46', accent: '#F96D00', text: '#F2F2F2' } } } }
        }
    </script>
</head>
<body class="bg-zzz-base text-zzz-text font-mono h-screen flex items-center justify-center">

    <%
        Product p = (Product) request.getAttribute("detail");
        String actionTitle = (p == null) ? "ADD NEW SIGNAL" : "EDIT SIGNAL DATA";
    %>

    <div class="w-full max-w-2xl bg-zzz-card border-2 border-zzz-accent p-8 shadow-2xl relative">
        <h2 class="text-2xl font-black text-zzz-accent mb-6 border-b border-gray-600 pb-2 uppercase">
            /// <%= actionTitle %>
        </h2>

        <form action="manage-product" method="POST" class="grid grid-cols-2 gap-6">
            <% if(p != null) { %> <input type="hidden" name="id" value="<%= p.getId() %>"> <% } %>

            <div class="col-span-1">
                <label class="block text-xs font-bold text-gray-400 mb-1">AGENT NAME</label>
                <input type="text" name="name" value="<%= (p!=null)?p.getName():"" %>" required class="w-full bg-zzz-base border border-gray-600 p-2 text-white focus:border-zzz-accent outline-none">
            </div>

            <div class="col-span-1">
                <label class="block text-xs font-bold text-gray-400 mb-1">PRICE (POLY)</label>
                <input type="number" name="price" value="<%= (p!=null)?p.getPrice():"" %>" required class="w-full bg-zzz-base border border-gray-600 p-2 text-white focus:border-zzz-accent outline-none">
            </div>

            <div class="col-span-1">
                <label class="block text-xs font-bold text-gray-400 mb-1">TYPE (e.g. Ice | Attack)</label>
                <input type="text" name="type" value="<%= (p!=null)?p.getType():"" %>" class="w-full bg-zzz-base border border-gray-600 p-2 text-white focus:border-zzz-accent outline-none">
            </div>

            <div class="col-span-1">
                <label class="block text-xs font-bold text-gray-400 mb-1">RARITY</label>
                <select name="rarity" class="w-full bg-zzz-base border border-gray-600 p-2 text-white focus:border-zzz-accent outline-none">
                    <option value="S-Rank" <%= (p!=null && "S-Rank".equals(p.getRarity()))?"selected":"" %>>S-Rank</option>
                    <option value="A-Rank" <%= (p!=null && "A-Rank".equals(p.getRarity()))?"selected":"" %>>A-Rank</option>
                </select>
            </div>

            <div class="col-span-1">
                <label class="block text-xs font-bold text-gray-400 mb-1">IMAGE FILE (e.g. ellen.png)</label>
                <input type="text" name="image" value="<%= (p!=null)?p.getImage():"" %>" class="w-full bg-zzz-base border border-gray-600 p-2 text-white focus:border-zzz-accent outline-none">
            </div>

            <div class="col-span-1">
                <label class="block text-xs font-bold text-gray-400 mb-1">YOUTUBE ID</label>
                <input type="text" name="videoId" value="<%= (p!=null)?p.getVideoId():"f7lQWp1f0kQ" %>" class="w-full bg-zzz-base border border-gray-600 p-2 text-white focus:border-zzz-accent outline-none">
            </div>

            <div class="col-span-2">
                <label class="block text-xs font-bold text-gray-400 mb-1">DESCRIPTION</label>
                <textarea name="description" rows="3" class="w-full bg-zzz-base border border-gray-600 p-2 text-white focus:border-zzz-accent outline-none"><%= (p!=null)?p.getDescription():"" %></textarea>
            </div>

            <div class="col-span-2 flex items-center gap-2">
                <input type="checkbox" name="isUpcoming" id="up" <%= (p!=null && p.isUpcoming())?"checked":"" %> class="w-4 h-4 accent-zzz-accent">
                <label for="up" class="text-sm font-bold text-gray-300">Mark as "Coming Soon" (Not for sale)</label>
            </div>

            <div class="col-span-2 flex gap-4 mt-4">
                <button type="submit" class="flex-1 bg-zzz-accent text-white py-3 font-black uppercase hover:bg-white hover:text-black transition-colors">
                    SAVE DATA
                </button>
                <a href="admin" class="flex-1 bg-transparent border border-gray-500 text-gray-400 py-3 font-bold uppercase text-center hover:text-white hover:border-white transition-colors">
                    CANCEL
                </a>
            </div>
        </form>
    </div>
</body>
</html>