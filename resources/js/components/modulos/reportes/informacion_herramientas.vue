<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Reportes - Información de Herramientas</h1>
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
                                                        :key="item"
                                                        :label="item"
                                                        :value="item"
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
                                                class="form-group col-md-12"
                                                v-if="
                                                    oReporte.filtro ==
                                                    'Herramienta'
                                                "
                                            >
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.herramienta_id,
                                                    }"
                                                    >Seleccionar
                                                    Herramienta/Equipo de
                                                    protección*</label
                                                >

                                                <el-select
                                                    class="w-100"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.herramienta_id,
                                                    }"
                                                    v-model="
                                                        oReporte.herramienta_id
                                                    "
                                                    filterable
                                                    placeholder="Herramienta/Equipo de protección"
                                                >
                                                    <el-option
                                                        v-for="item in listHerramientas"
                                                        :key="item.id"
                                                        :value="item.id"
                                                        :label="
                                                            item.codigo +
                                                            ' | ' +
                                                            item.nombre
                                                        "
                                                    >
                                                    </el-option>
                                                </el-select>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.herramienta_id"
                                                    v-text="
                                                        errors.herramienta_id[0]
                                                    "
                                                ></span>
                                            </div>
                                            <div
                                                class="form-group col-md-12"
                                                v-if="
                                                    oReporte.filtro ==
                                                    'Rango de fechas'
                                                "
                                            >
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.fecha_ini,
                                                        'text-danger':
                                                            errors.fecha_fin,
                                                    }"
                                                    >Indice un rango de
                                                    fechas*</label
                                                >
                                                <el-date-picker
                                                    class="w-full d-block"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.fecha_ini,
                                                        'is-invalid':
                                                            errors.fecha_fin,
                                                    }"
                                                    v-model="aFechas"
                                                    type="daterange"
                                                    range-separator="a"
                                                    start-placeholder="Fecha Inicial"
                                                    end-placeholder="Fecha Final"
                                                    format="dd/MM/yyyy"
                                                    value-format="yyyy-MM-dd"
                                                    @change="obtieneFechas()"
                                                >
                                                </el-date-picker>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.fecha_ini"
                                                    v-text="errors.fecha_ini[0]"
                                                ></span>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.fecha_fin"
                                                    v-text="errors.fecha_fin[0]"
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
                filtro: "Todos",
                herramienta_id: "",
                fecha_ini: "",
                fecha_fin: "",
            },
            aFechas: [],
            enviando: false,
            textoBtn: "Generar Reporte",
            listFiltro: ["Todos", "Herramienta"],
            listHerramientas: [],
            errors: [],
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getHerramientas();
    },
    methods: {
        getHerramientas() {
            axios.get("/admin/herramientas").then((response) => {
                this.listHerramientas = response.data.herramientas;
            });
        },
        limpiarFormulario() {
            this.oReporte.filtro = "Todos";
        },
        generaReporte() {
            this.enviando = true;
            let config = {
                responseType: "blob",
            };
            axios
                .post("/admin/reportes/informacion_herramientas", this.oReporte, config)
                .then((res) => {
                    this.errors = [];
                    this.enviando = false;
                    let pdfBlob = new Blob([res.data], {
                        type: "application/pdf",
                    });
                    let urlReporte = URL.createObjectURL(pdfBlob);
                    window.open(urlReporte);
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

                        if (error.response.status === 500) {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                html: responseObj.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
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
