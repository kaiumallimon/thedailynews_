import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:thedailynews/core/theme/app_colors.dart';
import 'package:thedailynews/features/home/providers/home_provider.dart';
import 'package:thedailynews/features/home/widgets/home_greetings.dart';
import 'package:thedailynews/features/home/widgets/home_searchbar.dart';
import 'package:thedailynews/features/home/widgets/home_title.dart';
import 'package:thedailynews/shared/widgets/app_logo.dart';
import 'package:thedailynews/shared/widgets/shimmer_loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    // Fetch breaking news only on initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isInitialLoad) {
        context.read<HomeProvider>().fetchBreakingNews();
        _isInitialLoad = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            // Fetch breaking news only when pulled to refresh
            await context.read<HomeProvider>().fetchBreakingNews();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                HomeGreeting(theme: theme),
                const SizedBox(height: 8),
                HomeTitle(theme: theme),
                const SizedBox(height: 16),
                HomeSearchBar(theme: theme),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Breaking News',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.titleTextColor,
                      fontFamily: GoogleFonts.sora().fontFamily,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Consumer<HomeProvider>(
                  builder: (context, homeProvider, child) {
                    if (homeProvider.isLoading &&
                        homeProvider.breakingNews == null) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const NewsCardShimmer(),
                            const SizedBox(height: 16),
                            const NewsCardShimmer(),
                            const SizedBox(height: 16),
                            const NewsCardShimmer(),
                          ],
                        ),
                      );
                    }

                    if (homeProvider.error != null &&
                        homeProvider.breakingNews == null) {
                      return Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: AppColors.errorColor,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Error: ${homeProvider.error}',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: AppColors.errorColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final breakingNews = homeProvider.breakingNews;
                    if (breakingNews == null) {
                      return Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.newspaper_outlined,
                                color: AppColors.iconColor,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No breaking news available',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: AppColors.textHintColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Breaking News Section
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: breakingNews.data.headlines.length,
                          itemBuilder: (context, index) {
                            final headline = breakingNews.data.headlines[index];
                            return Card(
                              color: AppColors.white,
                              margin: const EdgeInsets.only(bottom: 16),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: AppColors.borderColor,
                                  width: 1,
                                ),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  // TODO: Navigate to news detail
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    headline.image != null
                                        ? ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                              top: Radius.circular(12),
                                            ),
                                            child: Image.network(
                                              headline.image!,
                                              height: 200,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) =>
                                                  const SizedBox.shrink(),
                                            ),
                                          )
                                        : Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                              color:
                                                  AppColors.scaffoldBackground,
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                top: Radius.circular(12),
                                              ),
                                            ),
                                            width: double.infinity,
                                            child: Center(
                                              child: AppLogo(theme: theme),
                                            ),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            headline.title,
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.titleTextColor,
                                              fontFamily:
                                                  GoogleFonts.sora().fontFamily,
                                            ),
                                          ),
                                          if (headline.intro.isNotEmpty) ...[
                                            const SizedBox(height: 8),
                                            Text(
                                              headline.intro,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: AppColors.textColor,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 32),

                        // Categorized News Sections
                        ...homeProvider.filteredCategories.entries.map((entry) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(
                                  entry.key,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.titleTextColor,
                                    fontFamily: GoogleFonts.sora().fontFamily,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                itemCount: entry.value.length,
                                itemBuilder: (context, index) {
                                  final headline = entry.value[index];
                                  return Card(
                                    color: AppColors.white,
                                    margin: const EdgeInsets.only(bottom: 16),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: AppColors.borderColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () {
                                        // TODO: Navigate to news detail
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          headline.image != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                    top: Radius.circular(
                                                      12,
                                                    ),
                                                  ),
                                                  child: Image.network(
                                                    headline.image!,
                                                    height: 200,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) =>
                                                        const SizedBox.shrink(),
                                                  ),
                                                )
                                              : Container(
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                    color: AppColors
                                                        .scaffoldBackground,
                                                    borderRadius:
                                                        const BorderRadius
                                                            .vertical(
                                                      top: Radius.circular(
                                                        12,
                                                      ),
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                  child: Center(
                                                    child: AppLogo(
                                                      theme: theme,
                                                    ),
                                                  ),
                                                ),
                                          Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  headline.title,
                                                  style: theme
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors
                                                        .titleTextColor,
                                                    fontFamily:
                                                        GoogleFonts.sora()
                                                            .fontFamily,
                                                  ),
                                                ),
                                                if (headline
                                                    .intro.isNotEmpty) ...[
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    headline.intro,
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                      color:
                                                          AppColors.textColor,
                                                    ),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 32),
                            ],
                          );
                        }).toList(),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
