package com.icafe.demo.service.SatisticsService;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.TemporalAdjusters;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.icafe.demo.dto.OrderReportResponseDTO;
import com.icafe.demo.dto.OrderStatisticsResponseDTO;
import com.icafe.demo.dto.RevenueResponseDTO;
import com.icafe.demo.dto.TopSellingProductResponseDTO;
import com.icafe.demo.enums.OrderStatus;
import com.icafe.demo.enums.ProductSaleSortType;
import com.icafe.demo.repository.IOrderProductRepository;
import com.icafe.demo.repository.IOrderRepository;

import jakarta.transaction.Transactional;

@Service
public class SatisticsService implements ISatisticsService {
    @Autowired
    private IOrderProductRepository orderProductRepository;

    @Autowired
    private IOrderRepository orderRepository;

    @Override
    public List<TopSellingProductResponseDTO> getTopSellingProduct(LocalDateTime startDate, LocalDateTime endDate,
            int topN, ProductSaleSortType sortBy) {
        Pageable pageable = PageRequest.of(0, topN);
        return orderProductRepository.getTopSellingProductS(startDate, endDate, sortBy.toString(), pageable);
    }

    @Override
    public OrderStatisticsResponseDTO getOrderSatistics(LocalDateTime startDate, LocalDateTime endDate) {
        if (startDate.isAfter(endDate)) {
            throw new IllegalArgumentException("Start date can't bigger than end date!");
        }
        OrderStatisticsResponseDTO statistics = new OrderStatisticsResponseDTO();
        long totalOrder = orderRepository.countByCreatedAtBetween(startDate, endDate);
        long successfullOrder = orderRepository.countByCreatedAtBetweenAndStatus(startDate, endDate,
                OrderStatus.COMPLETED);
        long cancelledOrder = orderRepository.countByCreatedAtBetweenAndStatus(startDate, endDate,
                OrderStatus.CANCELLED);
        Double averageOrderValue = orderRepository.getAverageOrderValue(startDate, endDate, OrderStatus.COMPLETED);

        statistics.setAverageOrderValue(averageOrderValue);
        statistics.setCancelledOrder(cancelledOrder);
        statistics.setTotalOrder(totalOrder);
        statistics.setSuccessfullOrder(successfullOrder);

        return statistics;
    }

    @Transactional
    public OrderReportResponseDTO getOverviewReport(LocalDate dateview, String type) {
        LocalDateTime startDateTime;
        LocalDateTime endDateTime;

        switch (type.toLowerCase()) {
            case "daily":
                startDateTime = dateview.atStartOfDay();
                endDateTime = dateview.atTime(LocalTime.MAX);
                break;
            case "weekly":
                LocalDate weekStart = dateview.with(TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
                LocalDate weekEnd = dateview.with(TemporalAdjusters.nextOrSame(java.time.DayOfWeek.SUNDAY));
                startDateTime = weekStart.atStartOfDay();
                endDateTime = weekEnd.atTime(LocalTime.MAX);
                break;
            case "monthly":
                LocalDate monthStart = dateview.with(TemporalAdjusters.firstDayOfMonth());
                LocalDate monthEnd = dateview.with(TemporalAdjusters.lastDayOfMonth());
                startDateTime = monthStart.atStartOfDay();
                endDateTime = monthEnd.atTime(LocalTime.MAX);
                break;
            case "yearly":
                LocalDate yearStart = dateview.with(TemporalAdjusters.firstDayOfYear());
                LocalDate yearEnd = dateview.with(TemporalAdjusters.lastDayOfYear());
                startDateTime = yearStart.atStartOfDay();
                endDateTime = yearEnd.atTime(LocalTime.MAX);
                break;
            default:
                throw new IllegalArgumentException("Invalid type. Must be 'daily', 'weekly', 'monthly', or 'yearly'.");
        }

        OrderReportResponseDTO report = new OrderReportResponseDTO();
        report.setAvgOrderValue(
                Objects.requireNonNullElse(
                        orderRepository.getAverageOrderValue(startDateTime, endDateTime, OrderStatus.PENDING),
                        0.0));

        report.setTotalOrderQuantity(
                orderRepository.countByCreatedAtBetweenAndStatus(startDateTime, endDateTime, OrderStatus.PENDING));

        Double capitalPrice = Objects.requireNonNullElse(
                orderRepository.getCapitalPriceAtBetweenAndStatus(startDateTime, endDateTime,
                        OrderStatus.PENDING.toString()),
                0.0);

        Double revenue = Objects.requireNonNullElse(
                orderRepository.getRevenueAtBetweenAndStatus(startDateTime, endDateTime, OrderStatus.PENDING),
                0.0);

        report.setRevenue(revenue);
        report.setProfit(revenue - capitalPrice);
        return report;
    }

    public List<RevenueResponseDTO> getRevenuePeriod(LocalDate dateView, String type) {
        List<Object[]> results;
        String status = OrderStatus.PENDING.toString();
        switch (type) {
            case "daily":
                results = orderRepository.findDailyReport(dateView, status);
                break;
            case "weekly":
                results = orderRepository.findWeeklyReport(dateView, status);
                break;
            case "monthly":
                results = orderRepository.findMonthlyReport(dateView, status);
                break;
            case "yearly":
                results = orderRepository.findYearlyReport(dateView, status);
                break;
            default:
                throw new IllegalArgumentException(
                        "Invalid type: " + type + ". Expected 'daily', 'monthly', or 'yearly'.");
        }
        return results.stream()
                .map(row -> new RevenueResponseDTO(
                        row[0].toString(), // date
                        new BigDecimal(row[1].toString()),
                        new BigDecimal(row[2].toString())))
                .collect(Collectors.toList());
    }

}
