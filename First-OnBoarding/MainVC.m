//
//  MainVC.m
//  First-OnBoarding
//
//  Created by Uber on 03/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "MainVC.h"

#import "BasedOnBoardingVC.h"
#import "FirtstContentVC.h"
#import "SecondContentVC.h"

@interface MainVC ()

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIPageControl *customPageControl;

@end

@implementation MainVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Заполняем массивы
    [self setupDataToArray];
    
    // Инициализируем UIPageViewController
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    // Говорим что мы являемся его датасорсом
    self.pageViewController.dataSource = self;
    
    // Задаем текущий индекс для UIPageControl
    self.customPageControl.currentPage = 0;
    self.customPageControl.userInteractionEnabled = NO;
    
    // Добавляем на containerView наш UIPageViewController
    [self addController:self.pageViewController toContainerView:self.containerView];
    
    
    
    // Инициализируем контроллер для первого экрана
    FirtstContentVC *startVC = (FirtstContentVC*)[self viewControllerAtIndex:0];
    // Передаем этот контроллер в UIPageViewController
    [self.pageViewController setViewControllers: @[startVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}


// Метод который возвращает контроллер
- (BasedOnBoardingVC *)viewControllerAtIndex:(NSUInteger)index
{
    // Проверяем чтобы не вышли за приделы массива
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Инициализируем общего предка
    BasedOnBoardingVC* onBoardVC;

    // Если меньше или равно 6 - Инициализируем первый тип контроллера
    if (index<=6){
        FirtstContentVC* vc = (FirtstContentVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"FirtstContentVC"];
        // Настраиваем данные для отображения
        vc.textForTextView  = self.pageTitles[index];
        vc.imageFile        = self.pageImages[index];
        onBoardVC = vc;
    } else {
        // Если больше 6 - Инициализируем второй тип контроллера
        SecondContentVC* vc = (SecondContentVC*)[self.storyboard instantiateViewControllerWithIdentifier:@"SecondContentVC"];
        onBoardVC = vc;
    }
    // Присваиваем индекс
    onBoardVC.pageIndex = index;
    return onBoardVC;
}




#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((BasedOnBoardingVC*) viewController).pageIndex;
    self.customPageControl.currentPage = index;

    if ((index == 0) || (index == NSNotFound)) return nil;
    if (index < self.pageTitles.count-1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.customPageControl.alpha = 1;
        } completion: nil];
    }
    index--;
    return [self viewControllerAtIndex:index];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((BasedOnBoardingVC*) viewController).pageIndex;
    self.customPageControl.currentPage = index;

    if (index == NSNotFound)   return nil;
    if (index+1 == self.pageTitles.count) {
        
        [UIView animateWithDuration:0.1 animations:^{
            self.customPageControl.alpha = 0;
        } completion: nil];
    }
    index++;
    if (index == [self.pageTitles count]) return nil;
    return [self viewControllerAtIndex:index];
    
}

// Эти методы отвечают за автоматический показ UIPageControl
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    /*
    Если возвращать нули, тогда оно вообще не появиться
    Тут мы возвращаем ноль, но в свой кастомный UIPageControl отправляем все как надо
    */
    self.customPageControl.numberOfPages = [self.pageTitles count];
    return 0;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


- (void) addController:(UIViewController*) controller toContainerView:(UIView*) containerView
{
    controller.view.frame = containerView.bounds;

    [controller     willMoveToParentViewController:self];
    [containerView  addSubview:controller.view];
    [self           addChildViewController:controller];
    [controller     didMoveToParentViewController:self];

}



- (void) setupDataToArray {
    _pageImages = @[@"download.jpg", @"download-2.jpg", @"download-3.jpg", @"download-4.jpg", @"download-5.jpg", @"download-6.jpg", @"download-7.jpg",@"finalPhoto"];
    _pageTitles = @[@"Лошадь по кличке Команчи — единственная из выживших в результате «резни Кастера», 1887 год.",
                    @"Красное Облако и Американский Конь. Портрет двух самых известных вождей племени Оглала в полный рост: Американский Конь (в одежде на западный манер и с пистолетом в кобуре) и Красное Облако (в индейском головном уборе) пожимают руки возле типи. Фото было сделано в резервации Пайн Ридж или её окрестностях, 1891 год.",
                    @"Гостиница Minnekahta, Хот-Спрингс, Дакота. Мужчины и женщины позируют фотографу на крыльце и балконах гостиницы, 1889 год.",
                    @"Колорадо. Три здания с вывесками: «Grabill’s Mining Exchange», «Фотокарточки» и «Конюшня El Paso». 1888 год.",
                    @"Черные холмы, 1890 год.",
                    @"Памятник Дикому Биллу (Джеймс Батлер Хикок) — судебному исполнителю, Южная Дакота, 1891 год.",
                    @"Гордость Дэдвуда. Роскошное трехэтажное здание мэрии с башней, 1890 год.",
                    @""];
}



@end
