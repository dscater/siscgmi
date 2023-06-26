<template>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-3">
                    <button
                        class="btn btn-primary btn-block"
                        @click="muestraFiltro(1)"
                    >
                        Filtros 1
                    </button>
                </div>
                <div class="col-md-3">
                    <button
                        class="btn btn-primary btn-block"
                        @click="muestraFiltro(2)"
                    >
                        Filtros 2
                    </button>
                </div>
            </div>
        </div>
        <div class="col-md-12">
            <div class="row">
                <div
                    class="form-group col-md-4"
                    v-if="nro_filtro == 1 || nro_filtro == 2"
                >
                    <label>Año</label>
                    <select name="" id="" class="form-control" v-model="anio">
                        <option value="">Seleccione...</option>
                        <option
                            v-for="(item, index) in listAnios"
                            :value="item"
                            :key="index"
                        >
                            {{ item }}
                        </option>
                    </select>
                </div>
                <div class="form-group col-md-4" v-if="nro_filtro == 1">
                    <label>Mes</label>
                    <select name="" id="" class="form-control" v-model="mes">
                        <option value="">Seleccione...</option>
                        <option value="01">ENERO</option>
                        <option value="02">FEBRERO</option>
                        <option value="03">MARZO</option>
                        <option value="04">ABRIL</option>
                        <option value="05">MAYO</option>
                        <option value="06">JUNIO</option>
                        <option value="07">JULIO</option>
                        <option value="08">AGOSTO</option>
                        <option value="09">SEPTIEMBRE</option>
                        <option value="10">OCTUBRE</option>
                        <option value="11">NOVIMEBRE</option>
                        <option value="12">DICIEMBRE</option>
                    </select>
                </div>
                <div class="form-group col-md-4" v-if="nro_filtro == 2">
                    <label>Semana</label>
                    <input type="text" class="form-control" v-model="semana" />
                </div>
            </div>
            <Calendario
                :anio_mes="[anio, mes]"
                v-if="nro_filtro == 1"
            ></Calendario>
            <Semanal
                :anio_semana="[anio, semana]"
                v-if="nro_filtro == 2"
            ></Semanal>
        </div>
    </div>
</template>
<script>
import Calendario from "./calendario.vue";
import Semanal from "./Semanal.vue";
export default {
    components: {
        Calendario,
        Semanal,
    },
    props: ["mostrando"],
    data() {
        return {
            anio: "",
            mes: "",
            semana: "",
            datos: [],
            nro_filtro: 0,
            listAnios: [this.$moment().format("YYYY")],
        };
    },
    mounted() {
        this.getAnios();
    },
    methods: {
        muestraFiltro(val) {
            this.mes = "";
            this.semana = "";
            this.nro_filtro = val;
        },
        getAnios() {
            axios
                .get("/admin/orden_trabajos/getAniosOt")
                .then((response) => {
                    this.listAnios = response.data;
                })
                .catch((error) => {
                    this.listAnios = [$moment().format("YYYY")];
                    F;
                });
        },
    },
};
</script>
