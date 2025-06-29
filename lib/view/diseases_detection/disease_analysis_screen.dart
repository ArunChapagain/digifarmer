import 'package:digifarmer/models/gemini_analysis_model.dart';
import 'package:digifarmer/provider/gemini_provider.dart';
import 'package:digifarmer/widgets/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

class DiseaseAnalysisScreen extends StatelessWidget {
  final String diseaseName;
  final String detectedClass;

  const DiseaseAnalysisScreen({
    super.key,
    required this.diseaseName,
    required this.detectedClass,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFFE),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.h,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).primaryColor,
            leading: AnimatedPress(
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Remix.arrow_left_s_line,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'AI Analysis',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Consumer<GeminiProvider>(
              builder: (context, geminiProvider, child) {
                if (geminiProvider.isAnalyzing) {
                  return _buildLoadingState();
                } else if (geminiProvider.error != null) {
                  return _buildErrorState(geminiProvider.error!);
                } else if (geminiProvider.analysis != null) {
                  return _buildAnalysisContent(geminiProvider.analysis!);
                } else {
                  return _buildEmptyState();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          SizedBox(height: 80.h),
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: CircularProgressIndicator(
              strokeWidth: 4.w,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Analyzing Disease...',
            style: GoogleFonts.poppins(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'AI is generating comprehensive analysis',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          SizedBox(height: 60.h),
          Icon(
            Remix.error_warning_line,
            size: 80.sp,
            color: Colors.red[400],
          ),
          SizedBox(height: 16.h),
          Text(
            'Analysis Failed',
            style: GoogleFonts.poppins(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            error,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          SizedBox(height: 60.h),
          Icon(
            Remix.file_search_line,
            size: 80.sp,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            'No Analysis Available',
            style: GoogleFonts.poppins(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisContent(GeminiAnalysisModel analysis) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Disease Header
          _buildDiseaseHeader(),
          SizedBox(height: 24.h),
          
          // Analysis Sections
          _buildAnalysisSection(
            'Disease Summary',
            analysis.diseaseSummary,
            Remix.medicine_bottle_line,
            const Color(0xFF4A90E2),
          ),
          SizedBox(height: 16.h),
          
          _buildAnalysisSection(
            'Causes',
            analysis.causes,
            Remix.search_2_line,
            const Color(0xFFE74C3C),
          ),
          SizedBox(height: 16.h),
          
          _buildAnalysisSection(
            'Household Remedies',
            analysis.householdRemedies,
            Remix.home_heart_line,
            const Color(0xFF27AE60),
          ),
          SizedBox(height: 16.h),
          
          _buildAnalysisSection(
            'Agricultural Solutions',
            analysis.agriculturalSolutions,
            Remix.plant_line,
            const Color(0xFFF39C12),
          ),
          SizedBox(height: 16.h),
          
          _buildAnalysisSection(
            'Medicinal Treatment',
            analysis.medicinalTreatment,
            Remix.medicine_bottle_line,
            const Color(0xFF9B59B6),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildDiseaseHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6C63FF),
            const Color(0xFF5A52D3),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Remix.microscope_line,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Detection Results',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            diseaseName,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Class: $detectedClass',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisSection(
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 15.sp,
              height: 1.6,
              color: Colors.grey[700],
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
