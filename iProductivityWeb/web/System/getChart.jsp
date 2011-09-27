<%@page import="org.jfree.data.general.DefaultPieDataset"%>
<%@page import="org.jfree.data.general.PieDataset"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="org.jfree.data.category.DefaultCategoryDataset"%>
<%@page import="org.jfree.chart.ChartFactory"%>
<%@page import="org.jfree.chart.plot.PlotOrientation"%>
<%@ page import="java.io.*" %>
<%@ page import="org.jfree.chart.JFreeChart" %>
<%@ page import="org.jfree.chart.ChartUtilities" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% OutputStream o1 = response.getOutputStream();

            String name = (String) session.getAttribute("nameChart");
            String type = (String) session.getAttribute("typeChart");
            String ejex = (String) session.getAttribute("ejex");
            String ejey = (String) session.getAttribute("ejey");
            String email = (String) session.getAttribute("chartEmail");
            int nTasks[] = (int[]) session.getAttribute("nTasks");
            int days[] = (int[]) session.getAttribute("days");
            String time = (String) session.getAttribute("time");
            String dayOfWeek = null;

            //Crear el dataset...
            DefaultCategoryDataset dataset = new DefaultCategoryDataset();
            DefaultPieDataset piedataset = (DefaultPieDataset)session.getAttribute("global");

            if (!type.equalsIgnoreCase("PieChart")) {
                for (int i = 0; i < days.length; i++) {
                    if (time.equals("week")) {

                        switch (days[i]) {

                            case 1: {
                                dayOfWeek = "Sunday";
                                break;

                            }
                            case 2: {
                                dayOfWeek = "Monday";
                                break;

                            }
                            case 3: {
                                dayOfWeek = "Tuesday";
                                break;

                            }
                            case 4: {
                                dayOfWeek = "Wednesday";
                                break;

                            }
                            case 5: {
                                dayOfWeek = "Thursday";
                                break;

                            }
                            case 6: {
                                dayOfWeek = "Friday";
                                break;

                            }
                            case 7: {
                                dayOfWeek = "Saturday";
                                break;

                            }

                        }


                        dataset.addValue((Integer) nTasks[i], email, dayOfWeek);

                    } else {

                        dataset.addValue((Integer) nTasks[i], email, String.valueOf(days[i]));


                    }

                }
            }

            JFreeChart chart = null;

            if (type.equalsIgnoreCase("BarChart")) {
                chart = ChartFactory.createBarChart(name,
                        ejex,
                        ejey,
                        dataset, //Dataset
                        PlotOrientation.VERTICAL,
                        true,
                        true,
                        false);



            } else if (type.equalsIgnoreCase("BarChart3D")) {

                chart = ChartFactory.createBarChart3D(name,
                        ejex,
                        ejey,
                        dataset, //Dataset
                        PlotOrientation.VERTICAL,
                        true,
                        true,
                        false);


            } else if (type.equalsIgnoreCase("LineChart")) {

                chart = ChartFactory.createLineChart(name,
                        ejex,
                        ejey,
                        dataset, //Dataset
                        PlotOrientation.VERTICAL,
                        true,
                        true,
                        false);

            } else if (type.equalsIgnoreCase("LineChart3D")) {

                chart = ChartFactory.createLineChart3D(name,
                        ejex,
                        ejey,
                        dataset, //Dataset
                        PlotOrientation.VERTICAL,
                        true,
                        true,
                        false);





            } else if (type.equalsIgnoreCase("PieChart")) {

                chart = ChartFactory.createPieChart("Business Productivity", piedataset, false,true,false);
            }

            File image = File.createTempFile("image", "tmp");

            // Assume that we have the chart
            if (time.equals("week") || time.equals("global")) {
                ChartUtilities.saveChartAsPNG(image, chart, 600, 250);
            } else if(time.equals("month")){
                ChartUtilities.saveChartAsPNG(image, chart, 900, 250);
            }
            FileInputStream fileInStream = new FileInputStream(image);

            long fileLength;
            byte[] byteStream;

            fileLength = image.length();
            byteStream = new byte[(int) fileLength];
            fileInStream.read(byteStream, 0, (int) fileLength);

            response.setContentType("image/png");
            response.setContentLength((int) fileLength);
            response.setHeader("Cache-Control",
                    "no-store,no-cache, must-revalidate, post-check=0, pre-check=0");
            response.setHeader("Pragma", "no-cache");

            fileInStream.close();
            o1.write(byteStream);
            o1.flush();
            o1.close();

%>
