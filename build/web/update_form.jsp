<%@page import="model.GameUpdate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Manage Update - Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = { theme: { extend: { colors: { zzz: { base: '#222831', card: '#393E46', accent: '#F96D00', text: '#F2F2F2' } } } } }
    </script>
</head>
<body class="bg-zzz-base text-zzz-text font-mono h-screen flex items-center justify-center">

    <%
        GameUpdate up = (GameUpdate) request.getAttribute("up");
        String titleAction = (up == null) ? "POST NEW UPDATE" : "EDIT SYSTEM LOG";
        String dateVal = (up == null) ? new java.sql.Date(System.currentTimeMillis()).toString() : up.getDate().toString();
    %>

    <div class="w-full max-w-lg bg-zzz-card border-2 border-blue-500 p-8 shadow-2xl relative">
        <h2 class="text-2xl font-black text-blue-400 mb-6 border-b border-gray-600 pb-2 uppercase">
            /// <%= titleAction %>
        </h2>

        <form action="manage-update" method="POST" class="flex flex-col gap-4">
            <% if(up != null) { %> <input type="hidden" name="id" value="<%= up.getId() %>"> <% } %>

            <div>
                <label class="text-xs font-bold text-gray-400">TITLE</label>
                <input type="text" name="title" value="<%= (up!=null)?up.getTitle():"" %>" required class="w-full bg-zzz-base border border-gray-600 p-2 text-white focus:border-blue-500 outline-none">
            </div>

            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="text-xs font-bold text-gray-400">TYPE</label>
                    <select name="type" class="w-full bg-zzz-base border border-gray-600 p-2 text-white focus:border-blue-500 outline-none">
                        <option value="VERSION" <%= (up!=null&&"VERSION".equals(up.getType()))?"selected":"" %>>VERSION</option>
                        <option value="EVENT" <%= (up!=null&&"EVENT".equals(up.getType()))?"selected":"" %>>EVENT</option>
                        <option value="MAINTENANCE" <%= (up!=null&&"MAINTENANCE".equals(up.getType()))?"selected":"" %>>MAINTENANCE</option>
                        <option value="NEW AGENT" <%= (up!=null&&"NEW AGENT".equals(up.getType()))?"selected":"" %>>NEW AGENT</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-bold text-gray-400">VERSION (e.g. v1.3)</label>
                    <input type="text" name="version" value="<%= (up!=null)?up.getVersion():"" %>" class="w-full bg-zzz-base border border-gray-600 p-2 text-white focus:border-blue-500 outline-none">
                </div>
            </div>

            <div>
                <label class="text-xs font-bold text-gray-400">DATE</label>
                <input type="date" name="date" value="<%= dateVal %>" required class="w-full bg-zzz-base border border-gray-600 p-2 text-white focus:border-blue-500 outline-none">
            </div>

            <div>
                <label class="text-xs font-bold text-gray-400">CONTENT</label>
                <textarea name="content" rows="3" class="w-full bg-zzz-base border border-gray-600 p-2 text-white focus:border-blue-500 outline-none"><%= (up!=null)?up.getContent():"" %></textarea>
            </div>

            <div>
                <label class="text-xs font-bold text-gray-400">OFFICIAL LINK (Hoyoverse News)</label>
                <input type="text" name="link" value="<%= (up!=null)?up.getLink():"" %>" class="w-full bg-zzz-base border border-gray-600 p-2 text-white focus:border-blue-500 outline-none">
            </div>

            <div class="flex gap-4 mt-4">
                <button type="submit" class="flex-1 bg-blue-500 text-white py-3 font-black uppercase hover:bg-white hover:text-black transition-colors">SAVE</button>
                <a href="admin" class="flex-1 bg-transparent border border-gray-500 text-gray-400 py-3 font-bold uppercase text-center hover:text-white hover:border-white transition-colors">CANCEL</a>
            </div>
        </form>
    </div>
</body>
</html>