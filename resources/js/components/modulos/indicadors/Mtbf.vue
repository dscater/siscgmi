<template>
    <div class="row">
        <div class="col-md-12">
            <button
                class="btn btn-primary btn-block"
                :disabled="btnDisabled"
                @click="getCodificacion"
            >
                <i class="fa fa-chart-bar"></i> GENERAR
            </button>
        </div>
        <div class="col-md-12 mt-2">
            <h4
                class="text-center text-red font-weight-bold text-md"
                v-text="codificacion"
            ></h4>
        </div>
        <div class="col-md-12" id="container"></div>
    </div>
</template>
<script>
export default {
    props: {
        muestra: {
            type: Boolean,
            default: false,
        },
        equipo_id: {
            type: String,
            default: "",
        },
        anio: {
            type: Number,
            default: 0,
        },
        mes: {
            type: Number,
            default: 0,
        },
    },
    watch: {
        muestra(newVal) {
            if (newVal) {
                // this.getInfo();
            }
        },
        anio(newVal) {
            this.data.anio = newVal;
            // this.getInfo();
        },
        mes(newVal) {
            this.data.mes = newVal;
            // this.getInfo();
        },
        equipo_id(newVal) {
            this.data.equipo_id = newVal;
            // this.getInfo();
        },
    },
    computed: {
        btnDisabled() {
            let sw = false;
            if (
                !this.data.anio ||
                !this.data.mes ||
                this.data.equipo_id == ""
            ) {
                sw = true;
            }
            return sw;
        },
    },
    data() {
        return {
            data: {
                equipo_id: this.equipo_id,
                anio: this.anio,
                mes: this.mes,
                nro: 0,
            },
            codificacion: "",
        };
    },
    methods: {
        getInfo() {
            if (
                this.data.anio &&
                this.data.mes &&
                this.data.anio != 0 &&
                this.data.mes != 0 &&
                this.data.equipo_id != ""
            ) {
                axios
                    .get("/admin/indicadors/getMTFB", {
                        params: this.data,
                    })
                    .then((response) => {
                        console.log(response);
                        console.log("genera grafico");
                        Highcharts.chart("container", {
                            chart: {
                                type: "column",
                            },
                            title: {
                                text: "INDICADOR MTBF",
                            },
                            subtitle: {
                                text: "",
                            },
                            xAxis: {
                                type: "category",
                                // crosshair: true,
                                labels: {
                                    rotation: -45,
                                    style: {
                                        fontSize: "13px",
                                        fontFamily: "Verdana, sans-serif",
                                    },
                                },
                            },
                            yAxis: {
                                min: 0,
                                title: {
                                    text: "TOTAL",
                                },
                            },
                            legend: {
                                enabled: true,
                            },
                            plotOptions: {
                                series: {
                                    borderWidth: 0,
                                    dataLabels: {
                                        enabled: true,
                                        format: "{point.y:.2f}",
                                    },
                                },
                            },
                            tooltip: {
                                headerFormat:
                                    '<span style="font-size:10px"><b>{point.key}</b></span><table>',
                                pointFormat:
                                    '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                    '<td style="padding:0"><b>{point.y:.2f}</b></td></tr>',
                                footerFormat: "</table>",
                                shared: true,
                                useHTML: true,
                            },

                            series: [
                                {
                                    name: "MTBF",
                                    colorByPoint: true,
                                    // data: response.data.datos,
                                    data: response.data.datos,
                                    dataLabels: {
                                        rotation: 0,
                                        color: "#000000",
                                        format: "{point.y:.2f}", // one decimal
                                        y: 0, // 10 pixels down from the top
                                        style: {
                                            fontSize: "13px",
                                            fontFamily: "Verdana, sans-serif",
                                        },
                                    },
                                },
                            ],
                        });
                    })
                    .catch((error) => {
                        this.codificacion = "";
                    });
            }
        },
        getCodificacion() {
            axios
                .get("/admin/indicadors/getNro", {
                    params: { tipo: "MTBF" },
                })
                .then((response) => {
                    let nro = response.data;
                    this.data.nro = nro;
                    if (nro < 10) {
                        nro = "000" + nro;
                    } else if (nro < 100) {
                        nro = "00" + nro;
                    } else if (nro < 1000) {
                        nro = "0" + nro;
                    }
                    this.codificacion = `DM-${nro}-AN-KPI`;
                    console.log(this.data);
                    this.getInfo();
                });
        },
    },
};
</script>
<style></style>
