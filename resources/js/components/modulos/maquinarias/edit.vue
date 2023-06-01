<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Maquinarias</h1>
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
                                        :accion="'nuevo'"
                                        :maquinaria="oMaquinaria"
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
            oMaquinaria: {
                id: 0,
                equipo_id: "",
                descripcion: "",
                prioridad: "",
                ubicacion: "",
                tipo: "",
                marca: "",
                modelo: "",
                serie: "",
                costo: "",
                fecha_compra: "",
                fecha_instalacion: "",
                garantia_meses: "",
                peso: "",
                altura: "",
                ancho: "",
                largo: "",
                voltios: "",
                capacidad: "",
                e_tecnicas: "",
                fecha_ultimo_mantenimiento: "",
                fecha_utlimo_termino: "",
                estado: "",
                fabricantes: "",
                proveedor: "",
                terciarios: "",
                nombre_contacto: "",
                num_fono: "",
                correo: "",
                dir: "",
                num_identificacion: "",
                foto: "",
                archivo: "",
            },
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getMaquinaria();
    },
    methods: {
        getMaquinaria() {
            axios("/admin/maquinarias/" + this.id).then((response) => {
                this.oMaquinaria = response.data.maquinaria;
            });
        },
    },
};
</script>

<style></style>
