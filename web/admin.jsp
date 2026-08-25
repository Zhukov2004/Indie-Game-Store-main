<%@page import="model.Transaction"%>
<%@page import="model.GameUpdate"%>
<%@page import="model.Product"%>
<%@page import="model.Order"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="60"> <title>HDD System - Administrator</title>
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
        .bg-grid { background-image: radial-gradient(#393E46 1px, transparent 1px); background-size: 20px 20px; }
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #222831; }
        ::-webkit-scrollbar-thumb { background: #F96D00; border-radius: 4px; }
        
        tr:hover td { color: #fff; }
        .custom-scrollbar::-webkit-scrollbar { width: 6px; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: #555; }
    </style>
</head>
<body class="bg-zzz-base text-zzz-text font-mono h-screen flex flex-col bg-grid">

    <nav class="bg-red-900/90 backdrop-blur-md border-b border-red-500 p-4 sticky top-0 z-50 shadow-lg">
        <div class="max-w-[1800px] mx-auto flex justify-between items-center">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-black rounded flex items-center justify-center border border-red-500 shadow-[0_0_10px_red]">
                    <i class="fa-solid fa-user-secret text-xl text-red-500"></i>
                </div>
                <div>
                    <div class="text-xs text-red-400 font-bold uppercase tracking-widest">System Access</div>
                    <span class="text-xl font-black italic tracking-tighter text-white">/// ADMINISTRATOR PANEL</span>
                </div>
            </div>
            <div class="flex items-center gap-4">
                <span class="text-xs text-red-300 animate-pulse bg-red-900/50 px-2 py-1 rounded border border-red-500/30">
                    <i class="fa-solid fa-circle text-[8px] mr-1"></i> LIVE STREAM
                </span>
                <a href="home" class="bg-black text-white px-4 py-2 font-bold uppercase hover:bg-white hover:text-black transition-colors border border-red-500 text-sm shadow-lg">EXIT SYSTEM</a>
            </div>
        </div>
    </nav>

    <div class="flex-1 overflow-y-auto p-6">
        <div class="max-w-[1800px] mx-auto">
            
            <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                <div class="bg-zzz-card border-l-4 border-zzz-accent p-6 shadow-lg relative overflow-hidden group">
                    <div class="absolute right-2 top-2 opacity-10 text-6xl text-zzz-accent group-hover:scale-110 transition-transform"><i class="fa-solid fa-coins"></i></div>
                    <h3 class="text-xs text-gray-400 font-bold uppercase tracking-widest mb-1">Revenue (Today)</h3>
                    <div class="text-3xl font-black text-white font-mono flex items-center gap-2"><%= String.format("%,.0f", request.getAttribute("todayRev")) %> <span class="text-xs text-zzz-accent">POLY</span></div>
                </div>
                <div class="bg-zzz-card border-l-4 border-blue-500 p-6 shadow-lg relative overflow-hidden group">
                    <div class="absolute right-2 top-2 opacity-10 text-6xl text-blue-500 group-hover:scale-110 transition-transform"><i class="fa-solid fa-vault"></i></div>
                    <h3 class="text-xs text-gray-400 font-bold uppercase tracking-widest mb-1">Total Revenue</h3>
                    <div class="text-3xl font-black text-white font-mono"><%= String.format("%,.0f", request.getAttribute("totalRev")) %></div>
                </div>
                <div class="bg-zzz-card border-l-4 border-green-500 p-6 shadow-lg relative overflow-hidden group">
                    <div class="absolute right-2 top-2 opacity-10 text-6xl text-green-500 group-hover:scale-110 transition-transform"><i class="fa-solid fa-cart-shopping"></i></div>
                    <h3 class="text-xs text-gray-400 font-bold uppercase tracking-widest mb-1">Total Orders</h3>
                    <div class="text-3xl font-black text-white font-mono"><%= request.getAttribute("totalOrderCount") %></div>
                </div>
                <div class="bg-zzz-card border-l-4 border-purple-500 p-6 shadow-lg relative overflow-hidden group">
                    <div class="absolute right-2 top-2 opacity-10 text-6xl text-purple-500 group-hover:scale-110 transition-transform"><i class="fa-solid fa-users"></i></div>
                    <h3 class="text-xs text-gray-400 font-bold uppercase tracking-widest mb-1">Total Proxies</h3>
                    <div class="text-3xl font-black text-white font-mono"><%= request.getAttribute("totalUserCount") %></div>
                </div>
            </div>

            <div class="grid grid-cols-1 xl:grid-cols-2 gap-8 mb-8">
                
                <% 
                    List<Product> products = (List<Product>) request.getAttribute("listProducts");
                    List<User> users = (List<User>) request.getAttribute("listUsers");
                    List<Order> orders = (List<Order>) request.getAttribute("listOrders");
                    List<GameUpdate> updates = (List<GameUpdate>) request.getAttribute("listUpdates");
                    List<Transaction> trans = (List<Transaction>) request.getAttribute("listTrans");
                %>

                <div class="bg-zzz-card border border-gray-600 rounded p-6 shadow-xl h-[600px] flex flex-col">
                    <div class="flex justify-between items-center mb-4 border-b border-gray-600 pb-2">
                        <h2 class="text-xl font-black text-zzz-accent uppercase flex items-center gap-2">
                            <i class="fa-solid fa-box-archive"></i> Product Database <span class="text-xs bg-zzz-base px-2 py-1 rounded text-white ml-2"><%= (products!=null)?products.size():0 %></span>
                        </h2>
                        <a href="manage-product?action=add" class="bg-zzz-accent text-white px-3 py-1 text-xs font-bold uppercase hover:bg-white hover:text-black transition-colors rounded shadow-lg"><i class="fa-solid fa-plus mr-1"></i> Add Agent</a>
                    </div>
                    <div class="overflow-y-auto flex-1 custom-scrollbar pr-2">
                        <table class="w-full text-left text-sm">
                            <thead class="bg-zzz-base text-gray-400 sticky top-0 z-10 shadow-md">
                                <tr>
                                    <th class="p-3">ID</th>
                                    <th class="p-3">IMG</th>
                                    <th class="p-3">NAME</th>
                                    <th class="p-3">PRICE</th>
                                    <th class="p-3 text-center">ACTION</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-700">
                                <% if(products != null) { for(Product p : products) { %>
                                <tr class="hover:bg-zzz-base transition-colors group">
                                    <td class="p-3 font-mono text-gray-500">#<%= p.getId() %></td>
                                    <td class="p-3"><img src="images/<%= p.getImage() %>" class="w-8 h-8 object-cover rounded border border-gray-600" onerror="this.src='https://placehold.co/50'"></td>
                                    <td class="p-3 font-bold text-gray-300 group-hover:text-white"><%= p.getName() %></td>
                                    <td class="p-3 font-mono text-zzz-accent"><%= String.format("%,.0f", p.getPrice()) %></td>
                                    <td class="p-3 text-center flex justify-center gap-3">
                                        <a href="manage-product?action=edit&id=<%= p.getId() %>" class="text-blue-400 hover:text-white" title="Edit"><i class="fa-solid fa-pen"></i></a>
                                        <a href="manage-product?action=delete&id=<%= p.getId() %>" onclick="return confirm('Delete <%= p.getName() %>?')" class="text-red-500 hover:text-white" title="Delete"><i class="fa-solid fa-trash"></i></a>
                                    </td>
                                </tr>
                                <% } } %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="flex flex-col gap-6 h-[600px] overflow-hidden">
                    
                    <div class="bg-zzz-card border border-gray-600 rounded p-6 shadow-xl flex-1 flex flex-col min-h-0">
                        <h2 class="text-xl font-black text-purple-400 mb-4 border-b border-gray-600 pb-2 uppercase flex items-center gap-2">
                            <i class="fa-solid fa-users-gear"></i> Proxy Access <span class="text-xs bg-purple-900/50 text-purple-300 px-2 py-1 rounded"><%= (users!=null)?users.size():0 %></span>
                        </h2>
                        <div class="overflow-y-auto flex-1 custom-scrollbar pr-2">
                            <table class="w-full text-left text-sm">
                                <thead class="bg-zzz-base text-gray-400 sticky top-0 z-10">
                                    <tr>
                                        <th class="p-2">USER</th>
                                        <th class="p-2">NAME</th>
                                        <th class="p-2 text-center">STATUS</th>
                                        <th class="p-2 text-center">ACTION</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-700">
                                    <% if(users!=null) { for(User u : users) { %>
                                    <tr class="hover:bg-zzz-base transition-colors">
                                        <td class="p-2 font-bold text-white"><%= u.getUsername() %></td>
                                        <td class="p-2 text-gray-400"><%= u.getFullName() %></td>
                                        <td class="p-2 text-center">
                                            <% if(u.isLocked()) { %>
                                                <span class="bg-red-900 text-red-400 text-[10px] px-2 py-1 rounded border border-red-500 font-bold">LOCKED</span>
                                            <% } else { %>
                                                <span class="bg-green-900 text-green-400 text-[10px] px-2 py-1 rounded border border-green-500 font-bold">ACTIVE</span>
                                            <% } %>
                                        </td>
                                        <td class="p-2 text-center">
                                            <% if(u.isLocked()) { %>
                                                <a href="manage-user?action=unlock&id=<%= u.getId() %>" class="text-green-500 hover:text-white" title="Unlock"><i class="fa-solid fa-lock-open"></i></a>
                                            <% } else { %>
                                                <a href="manage-user?action=lock&id=<%= u.getId() %>" class="text-red-500 hover:text-white" title="Lock" onclick="return confirm('Block this user?')"><i class="fa-solid fa-lock"></i></a>
                                            <% } %>
                                        </td>
                                    </tr>
                                    <% } } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="bg-zzz-card border border-gray-600 rounded p-6 shadow-xl flex-1 flex flex-col min-h-0">
                        <h2 class="text-xl font-black text-yellow-400 mb-4 border-b border-gray-600 pb-2 uppercase flex items-center gap-2">
                            <i class="fa-solid fa-money-bill-transfer"></i> Financial Requests <span class="text-xs bg-yellow-900/50 text-yellow-300 px-2 py-1 rounded"><%= (trans!=null)?trans.size():0 %></span>
                        </h2>
                        <div class="overflow-y-auto flex-1 custom-scrollbar pr-2">
                            <table class="w-full text-left text-sm">
                                <thead class="bg-zzz-base text-gray-400 sticky top-0 z-10">
                                    <tr>
                                        <th class="p-2">USER</th>
                                        <th class="p-2 text-right">AMOUNT</th>
                                        <th class="p-2 text-center">STATUS</th>
                                        <th class="p-2 text-center">ACTION</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-700">
                                    <% if(trans!=null) { for(Transaction t : trans) { %>
                                    <tr class="hover:bg-zzz-base transition-colors">
                                        <td class="p-2 font-bold text-white"><%= t.getUserName() %></td>
                                        <td class="p-2 text-right font-mono text-white"><%= String.format("%,.0f", t.getAmount()) %></td>
                                        <td class="p-2 text-center">
                                            <% if(t.getStatus().equals("PENDING")) { %> <span class="text-yellow-400 font-bold text-[10px]">PENDING</span> <% } %>
                                            <% if(t.getStatus().equals("APPROVED")) { %> <span class="text-green-400 font-bold text-[10px]">APPROVED</span> <% } %>
                                            <% if(t.getStatus().equals("REJECTED")) { %> <span class="text-red-400 font-bold text-[10px]">REJECTED</span> <% } %>
                                        </td>
                                        <td class="p-2 text-center">
                                            <% if(t.getStatus().equals("PENDING")) { %>
                                                <a href="manage-transaction?action=approve&id=<%= t.getId() %>" class="text-green-500 hover:text-white mr-2"><i class="fa-solid fa-check"></i></a>
                                                <a href="manage-transaction?action=reject&id=<%= t.getId() %>" class="text-red-500 hover:text-white"><i class="fa-solid fa-xmark"></i></a>
                                            <% } else { %>
                                                <span class="text-gray-600">-</span>
                                            <% } %>
                                        </td>
                                    </tr>
                                    <% } } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>

            <div class="bg-zzz-card border border-gray-600 rounded p-6 shadow-xl">
                <div class="flex justify-between items-center mb-4 border-b border-gray-600 pb-2">
                    <h2 class="text-xl font-black text-blue-400 uppercase flex items-center gap-2">
                        <i class="fa-solid fa-newspaper"></i> System Updates
                    </h2>
                    <a href="manage-update?action=add" class="bg-blue-500 text-white px-3 py-1 text-xs font-bold uppercase hover:bg-white hover:text-black transition-colors rounded shadow-lg">
                        <i class="fa-solid fa-plus mr-1"></i> Post News
                    </a>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-sm">
                        <thead class="bg-zzz-base text-gray-400">
                            <tr>
                                <th class="p-3">DATE</th>
                                <th class="p-3">TYPE</th>
                                <th class="p-3">VERSION</th>
                                <th class="p-3">TITLE</th>
                                <th class="p-3 text-center">ACTION</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-700">
                            <% if(updates!=null) { for(GameUpdate up : updates) { %>
                            <tr class="hover:bg-zzz-base transition-colors">
                                <td class="p-3 font-mono text-gray-500"><%= up.getDate() %></td>
                                <td class="p-3 font-bold text-zzz-accent"><%= up.getType() %></td>
                                <td class="p-3 text-gray-300"><%= up.getVersion() %></td>
                                <td class="p-3 text-white"><%= up.getTitle() %></td>
                                <td class="p-3 text-center flex justify-center gap-4">
                                    <a href="manage-update?action=edit&id=<%= up.getId() %>" class="text-blue-400 hover:text-white"><i class="fa-solid fa-pen"></i></a>
                                    <a href="manage-update?action=delete&id=<%= up.getId() %>" class="text-red-500 hover:text-white" onclick="return confirm('Delete news?')"><i class="fa-solid fa-trash"></i></a>
                                </td>
                            </tr>
                            <% } } %>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>

</body>
</html>