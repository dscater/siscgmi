<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Indicadores</h1>
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
                                <div class="row">
                                    <div class="col-md-4 form-group">
                                        <button
                                            class="btn btn-primary btn-block"
                                            @click="muestraIndicador('mtbf')"
                                        >
                                            MTBF
                                        </button>
                                    </div>
                                    <div class="col-md-4 form-group">
                                        <button
                                            class="btn btn-primary btn-block"
                                            @click="muestraIndicador('mttr')"
                                        >
                                            MTTR
                                        </button>
                                    </div>
                                    <div class="col-md-4 form-group">
                                        <button
                                            class="btn btn-primary btn-block"
                                            @click="
                                                muestraIndicador(
                                                    'disponibilidad'
                                                )
                                            "
                                        >
                                            Disponibilidad
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <div
                                    class="row"
                                    v-if="
                                        muestra_mtbf ||
                                        muestra_mttr ||
                                        muestra_disponibilidad
                                    "
                                >
                                    <div class="col-md-4 form-group">
                                        <label>Año*</label>
                                        <select
                                            name=""
                                            id=""
                                            class="form-control"
                                            v-model="oIndicador.anio"
                                        >
                                            <option value="">
                                                Seleccione...
                                            </option>
                                            <option
                                                v-for="(
                                                    item, index
                                                ) in listAnios"
                                                :value="item"
                                                :key="index"
                                            >
                                                {{ item }}
                                            </option>
                                        </select>
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.anio"
                                            v-text="errors.anio[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-4 form-group">
                                        <label>Mes*</label>
                                        <select
                                            name=""
                                            id=""
                                            class="form-control"
                                            v-model="oIndicador.mes"
                                        >
                                            <option value="">
                                                Seleccione...
                                            </option>
                                            <option value="1">ENERO</option>
                                            <option value="2">FEBRERO</option>
                                            <option value="3">MARZO</option>
                                            <option value="4">ABRIL</option>
                                            <option value="5">MAYO</option>
                                            <option value="6">JUNIO</option>
                                            <option value="7">JULIO</option>
                                            <option value="8">AGOSTO</option>
                                            <option value="9">
                                                SEPTIEMBRE
                                            </option>
                                            <option value="10">OCTUBRE</option>
                                            <option value="11">
                                                NOVIMEBRE
                                            </option>
                                            <option value="12">
                                                DICIEMBRE
                                            </option>
                                        </select>
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.mes"
                                            v-text="errors.mes[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-4 form-group">
                                        <label>Equipo*</label>
                                        <el-select
                                            placeholder="Seleccionar equipo"
                                            class="w-100"
                                            :class="{
                                                'is-invalid': errors.equipo_id,
                                            }"
                                            v-model="oIndicador.equipo_id"
                                            clearable
                                            filterable
                                        >
                                            <el-option
                                                v-for="item in listEquipos"
                                                :key="item.id"
                                                :value="item.id"
                                                :label="item.full_name"
                                            ></el-option>
                                        </el-select>
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.equipo_id"
                                            v-text="errors.equipo_id[0]"
                                        ></span>
                                    </div>
                                </div>
                                <Mtbf
                                    v-if="muestra_mtbf"
                                    :anio="parseInt(oIndicador.anio)"
                                    :mes="parseInt(oIndicador.mes)"
                                    :equipo_id="'' + oIndicador.equipo_id"
                                    :muestra="muestra_mtbf"
                                ></Mtbf>
                                <Mttr
                                    v-if="muestra_mttr"
                                    :anio="parseInt(oIndicador.anio)"
                                    :mes="parseInt(oIndicador.mes)"
                                    :equipo_id="'' + oIndicador.equipo_id"
                                    :muestra="muestra_mttr"
                                ></Mttr>
                                <Disponibilidad
                                    v-if="muestra_disponibilidad"
                                    :anio="parseInt(oIndicador.anio)"
                                    :mes="parseInt(oIndicador.mes)"
                                    :equipo_id="'' + oIndicador.equipo_id"
                                    :muestra="muestra_disponibilidad"
                                ></Disponibilidad>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
import Mtbf from "./Mtbf.vue";
import Mttr from "./Mttr.vue";
import Disponibilidad from "./Disponibilidad.vue";
export default {
    components: {
        Mtbf,
        Mttr,
        Disponibilidad,
    },
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            oIndicador: {
                id: 0,
                nro: "",
                tipo: "",
            },
            listEquipos: [],
            listAnios: [this.$moment().format("YYYY")],
            enviando: false,
            errors: [],
            total_anterior: 0,
            muestra_mtbf: false,
            muestra_mttr: false,
            muestra_disponibilidad: false,
        };
    },
    computed: {
        MesTxt() {
            const meses = [
                "ENERO",
                "FEBRERO",
                "MARZO",
                "ABRIL",
                "MAYO",
                "JUNIO",
                "JULIO",
                "AGOSTO",
                "SEPTIEMBRE",
                "OCTUBRE",
                "NOVIEMBRE",
                "DICIEMBRE",
            ];
            const mesIndex = parseInt(this.oIndicador.mes, 10) - 1;
            let texto_mes = meses[mesIndex] ? meses[mesIndex] : "Mes inválido";
            return `TIEMPO DISPONIBLE MES ${texto_mes}`;
        },
    },
    mounted() {
        this.loadingWindow.close();
        this.getAnios();
        this.getEquipos();
    },
    methods: {
        getEquipos() {
            axios.get("/admin/equipos").then((response) => {
                this.listEquipos = response.data.equipos;
            });
        },
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
        muestraIndicador(indicador) {
            this.muestra_mtbf = false;
            this.muestra_mttr = false;
            this.muestra_disponibilidad = false;
            if (indicador == "mtbf") {
                this.muestra_mtbf = true;
            }
            if (indicador == "mttr") {
                this.muestra_mttr = true;
            }
            if (indicador == "disponibilidad") {
                this.muestra_disponibilidad = true;
            }
        },
    },
};
</script>

<style></style>
