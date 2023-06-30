<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Modelo Deterministico</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Modificar registro</h3>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <Formulario
                                        :accion="'edit'"
                                        :modelo_deterministico="
                                            oModeloDeterministico
                                        "
                                    ></Formulario>
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
import Formulario from "./Formulario.vue";
export default {
    props: ["id"],
    components: {
        Formulario,
    },
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            oModeloDeterministico: {
                id: 0,
                codigo: "",
                nombre: "",
                descripcion: "",
                repuesto_id: "",
                sm: "",
                it: "",
                cpo: "",
                ct_ordenar: "",
                c_ins: "",
                c_em: "",
                c_ordenar: "",
                precio_compra: "",
                ct_adqui: "",
                c_impor: "",
                c_alma_ext: "",
                oc_adqui: "",
                c_adqui: "",
                c_alqui: "",
                area_ocupada: "",
                c_espa: "",
                vp_rep: "",
                cantp_rep: "",
                costop_rep: "",
                tasa_ia: "",
                costo_capital: "",
                ct_almacenamiento: "",
                c_depreciacion: "",
                c_gi: "",
                oc_mantenimiento: "",
                c_mantenimiento: "",
                leadtime: "",
                procesamiento_pedido: "",
                procesamiento_pedido_calculado: "",
                fabricacion_productos: "",
                tiempo_transito: "",
                inspeccion_control: "",
                unidad: 12,
            },
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getModeloDeterministico();
    },
    methods: {
        getModeloDeterministico() {
            axios("/admin/modelo_deterministicos/" + this.id).then(
                (response) => {
                    this.oModeloDeterministico =
                        response.data.modelo_deterministico;
                }
            );
        },
    },
};
</script>

<style></style>
