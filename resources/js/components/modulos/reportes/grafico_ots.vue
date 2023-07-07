<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Reportes - Gráfico de Ordenes de Trabajo</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="ml-auto mr-auto col-md-5">
                                    <form>
                                        <div class="row">
                                            <div class="form-group col-md-12">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.filtro,
                                                    }"
                                                    >Seleccione*</label
                                                >
                                                <el-select
                                                    v-model="oReporte.filtro"
                                                    filterable
                                                    placeholder="Seleccione"
                                                    class="d-block"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.filtro,
                                                    }"
                                                >
                                                    <el-option
                                                        v-for="item in listFiltro"
                                                        :key="item.id"
                                                        :value="item.id"
                                                        :label="item.label"
                                                    >
                                                    </el-option>
                                                </el-select>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.filtro"
                                                    v-text="errors.filtro[0]"
                                                ></span>
                                            </div>
                                            <div
                                                class="form-group col-md-6"
                                                v-if="
                                                    oReporte.filtro ==
                                                    'anio_mes'
                                                "
                                            >
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.anio,
                                                    }"
                                                    >Seleccione Año*</label
                                                >
                                                <el-select
                                                    v-model="oReporte.anio"
                                                    filterable
                                                    placeholder="Seleccione"
                                                    class="d-block"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.anio,
                                                    }"
                                                >
                                                    <el-option
                                                        v-for="item in listAnios"
                                                        :key="item"
                                                        :value="item"
                                                        :label="item"
                                                    >
                                                    </el-option>
                                                </el-select>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.anio"
                                                    v-text="errors.anio[0]"
                                                ></span>
                                            </div>
                                            <div
                                                class="form-group col-md-6"
                                                v-if="
                                                    oReporte.filtro ==
                                                    'anio_mes'
                                                "
                                            >
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.mes,
                                                    }"
                                                    >Seleccione Mes*</label
                                                >
                                                <el-select
                                                    v-model="oReporte.mes"
                                                    filterable
                                                    placeholder="Seleccione"
                                                    class="d-block"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.mes,
                                                    }"
                                                >
                                                    <el-option
                                                        v-for="item in listMeses"
                                                        :key="item.id"
                                                        :value="item.id"
                                                        :label="item.label"
                                                    >
                                                    </el-option>
                                                </el-select>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.mes"
                                                    v-text="errors.mes[0]"
                                                ></span>
                                            </div>
                                        </div>
                                    </form>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <el-button
                                                type="primary"
                                                class="bg-primary w-full"
                                                :loading="enviando"
                                                @click="generaReporte()"
                                                >{{ textoBtn }}</el-button
                                            >
                                        </div>
                                        <div class="col-md-12">
                                            <el-button
                                                type="default"
                                                class="w-full mt-1"
                                                @click="limpiarFormulario()"
                                                >Reiniciar</el-button
                                            >
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <h4>Reporte:</h4>
                                    </div>
                                    <div class="col-md-12" id="container"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
export default {
    data() {
        return {
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            errors: [],
            oReporte: {
                filtro: "todos",
                equipo: "",
                anio: "",
                mes: "",
            },
            aFechas: [],
            enviando: false,
            textoBtn: "Generar Reporte",
            listFiltro: [
                { id: "todos", label: "Todos" },
                { id: "anio_mes", label: "Año/Mes" },
            ],
            listEquipos: [],
            listAnios: [],
            listMeses: [
                { id: "01", label: "Enero" },
                { id: "02", label: "Febrero" },
                { id: "03", label: "Marzo" },
                { id: "04", label: "Abril" },
                { id: "05", label: "Mayo" },
                { id: "06", label: "Junio" },
                { id: "07", label: "Julio" },
                { id: "08", label: "Agosto" },
                { id: "09", label: "Septiembre" },
                { id: "10", label: "Octubre" },
                { id: "11", label: "Noviembre" },
                { id: "12", label: "Diciembre" },
            ],
            errors: [],
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getAnios();
    },
    methods: {
        getAnios() {
            axios
                .get("/admin/orden_trabajos/getAniosOt")
                .then((response) => {
                    this.listAnios = response.data;
                })
                .catch((error) => {
                    this.listAnios = [$moment().format("YYYY")];
                });
        },
        limpiarFormulario() {
            this.oReporte.filtro = "todos";
        },
        generaReporte() {
            this.enviando = true;
            axios
                .post("/admin/reportes/resumen_ots", this.oReporte)
                .then((res) => {
                    this.errors = [];
                })
                .catch(async (error) => {
                    let responseObj = await error.response.data.text();
                    responseObj = JSON.parse(responseObj);
                    console.log(error);
                    this.enviando = false;
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = responseObj.errors;
                        }
                        if (
                            error.response.status === 420 ||
                            error.response.status === 419 ||
                            error.response.status === 401
                        ) {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                html: responseObj.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                            window.location = "/";
                        }
                    }
                });
        },
        obtieneFechas() {
            this.oReporte.fecha_ini = this.aFechas[0];
            this.oReporte.fecha_fin = this.aFechas[1];
        },
    },
};
</script>

<style></style>
