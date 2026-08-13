import 'package:flutter/material.dart';

import 'widgets/dashboard_header.dart';
import 'widgets/dashboard_stats.dart';
import 'widgets/low_stock_alert.dart';
import 'widgets/quick_actions.dart';
import 'widgets/recent_activity.dart';
import 'widgets/sales_chart.dart';
import 'widgets/summary_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF2F7),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "BizBook Dashboard",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: .8,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white24,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
        ],

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff3949AB),
                Color(0xff1E88E5),
              ],
            ),
          ),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffEEF2F7),
              Colors.white,
            ],
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            padding: const EdgeInsets.all(18),

            child: Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.92),

                borderRadius: BorderRadius.circular(28),

                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.15),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  DashboardHeader(),

                  SizedBox(height: 26),

                  DashboardStats(
                    totalProducts: 12,
                    totalCustomers: 8,
                    totalSales: 15,
                    totalRevenue: 145000,
                  ),

                  SizedBox(height: 26),

                  LowStockAlert(),

                  SizedBox(height: 26),

                  SalesChart(),

                  SizedBox(height: 26),

                  SummaryCardSection(),

                  SizedBox(height: 26),

                  QuickActions(),

                  SizedBox(height: 26),

                  RecentActivity(),

                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}